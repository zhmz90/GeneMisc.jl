
@doc """  download genecode file to data_dir
""" ->
function download_gencode()
    gz_genecode = string(genecode_fl, ".gz")
    if !isdir(data_dir)
        mkdir(data_dir)
    end
    info("Downloading gencode.v19.annotation.gtf now")
    cmd = `wget -c
    ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz
    $(abspath(gz_genecode))`
    run(cmd)
    
    run(`guzip $(gz_genecode) $(genecode_fl)`)
end

@doc """ read gtf file with out header info
""" ->
function read_gtf()
    if !isfile(genecode_fl)
        download_gencode()
    end
    num_line = countlines(genecode_fl)
    info("gtf total lines $num_line")
    records =  Array{ASCIIString,2}(num_line,9)
    idx = 0
    open(genecode_fl) do file
        while !eof(file)
            line = readline(file)
            if line[1] == '#'
                continue
            end
            fields = split(strip(line,'\n'),"\t")
            if fields[3] != "gene"
                continue
            end
            idx += 1
            idx % 1000_000 == 0 && info("processing $idx line now")
            num_field = length(fields)
            @assert num_field == 9
            records[idx,:] = fields
        end
    end
    records[1:idx,:]
end

@doc """ get gene_name, chr, start, end  given a record
         mgp means mutation genome position
""" ->
function get_gene_mgp(fields::Array{ASCIIString,1})
    @assert length(fields) == 9
    chr = convert(ASCIIString, fields[1])
#    ty  = convert(ASCIIString, fields[3])
    st  = convert(ASCIIString, fields[4])
    ed  = convert(ASCIIString, fields[5])
    gene_names = filter(subfield->contains(subfield, "gene_name"), split(fields[end],";"))
    @assert length(gene_names) == 1
    gene_name = split(gene_names[1]," ")[end]
    gene_name = split(gene_name,"\"")[2]
#    @show gene_name
    gene_name = convert(ASCIIString, gene_name)
#    vcat(gene_name,chr,st,ed)'
    gene_name,chr,st,ed
end

@doc """ get chr, start, end, gene_name given records
""" ->
function get_gene_mgp(data::Array{ASCIIString,2})
    info("begin get_gene_mgp")
    #@assert size(data,2) == 9
    n = size(data,1)

    geneloc = Dict{ASCIIString,Tuple{ASCIIString,ASCIIString,ASCIIString}}()
    for i = 1:n
        gene_name,chr,st,ed = get_gene_mgp(data[i,:])
        geneloc[gene_name] = (chr,st,ed)
    end

    geneloc
end

@doc """ get gene_name, chr, start, end  given a record
         mgp means mutation genome position
""" ->
function get_gene_mgp(fields::Array{ASCIIString,1})
    @assert length(fields) == 9
    chr = convert(ASCIIString, fields[1])
    st  = convert(ASCIIString, fields[4])
    ed  = convert(ASCIIString, fields[5])
    gene_names = filter(subfield->contains(subfield, "gene_name"), split(fields[end],";"))
    @assert length(gene_names) == 1
    gene_name = split(gene_names[1]," ")[end]
    gene_name = split(gene_name,"\"")[2]
    gene_name = convert(ASCIIString, gene_name)
    vcat(gene_name,chr,st,ed)'
end

@doc """ get chr, start, end, gene_name given records
""" ->
function get_gene_mgp(data::Array{ASCIIString,2})
    info("begin get_gene_mgp")
    @assert size(data,2) == 9
    n = size(data,1)
    gene_mgps = @parallel (hcat) for i = 1:n
        get_gene_mgp(data[i,:])
    end
    gene_mgps
end

@doc """ Given a location, find which gene it is from.
         So the index is (chr,pos)=>genename
         Save it to disk
""" ->
function pos_gene_dict(data::Array{ASCIIString,2})
    @assert size(data,2) == 4
    #TODO check st,eds not intersect
    #pos_gene = Dict{Tuple{ASCIIString,Int64}, ASCIIString}()
    info("begin pos_gene_dict big paralel for loop")
    pos_gene = @parallel (union) for i = 1:size(data,1)
        genename = data[i,1]
        chr      = data[i,2]
        st       = data[i,3]
        ed       = data[i,4]
        @assert st<=ed
        pos_genes = Array{Pair{Tuple{ASCIIString,Int64},ASCIIString},1}(ed-st+1)
        for i = 1:(ed-st+1)
            pos_genes[i] = Pair{Tuple{ASCIIString,Int64},ASCIIString}((chr,pos),genename)
        end
        pos_genes
    end
    save(pos_gene_dict_fl, "pos_gene_dict", pos_gene)

    nothing
end

@doc """ build index pos_gene dict
""" ->
function build_pos_gene()
    info("reading gtf file to memory")
    @time gtf = read_gtf()
    info("Getting gene position from gtf data")
    @time gene_mgps = get_gene_mgp(gtf)

    info("get_gene mgp successed")
    pos_gene_dict(gene_mgps)
    
    true
end
