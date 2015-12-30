const chr_rngs_exon_fl = joinpath(data_dir, "chr_range_exon_dict.jld")
const rng_exon_dict_fl = joinpath(data_dir, "rng_exon_dict.jld")
const sts_exon_fl = joinpath(data_dir, "sts_exon.jld")
const eds_exon_fl = joinpath(data_dir, "eds_exon.jld")

@doc """ buid index for query_exon
""" ->
function build_index_exon()
    info("Building index for querying exon")
    gtf_data = read_gtf()
    # below can be parallel
    chr_range_index(gtf_data)
    #range_exon_index(gtf_data)
    
    nothing
end

@doc """ build the index of chr=>sorted_ranges from exon data
         
""" ->
function chr_range_index(data::Array{ASCIIString,2})
    chrs = data[:,1]
    rngs = ranges_data(data)
    chr_rng_pair = sort(collect(zip(chrs, rngs)))
    chr_rngs_dict = Dict{ASCIIString, Set{Tuple{UInt64,UInt64}}}()
    last_chr = ""
#    @show chr_rng_pair
    for (chr,rng) in chr_rng_pair
        if chr == last_chr
            rng_num = map(x->parse(UInt64,x),rng)
            push!(chr_rngs_dict[chr], rng_num)
        else
            rng_num = map(x->parse(UInt64,x), rng)
            chr_rngs_dict[chr] = Set{Tuple{UInt64,UInt64}}([rng_num])
            last_chr = chr
        end
    end
 #   @show chr_rngs_dict
 #   return
    tmp = map(x->Pair(x[1],sort(collect(x[2]))), collect(chr_rngs_dict))
    chr_rngs_dict = Dict(tmp)

    save(chr_rngs_exon_fl, "chr_rngs_exon_dict", chr_rngs_dict)
    
    nothing
end

@doc """ build the index of range=>gene_name,exon_number from exon data
""" ->
function range_exon_index(data::Array{ASCIIString,2})
    info("buiding range_exon_index ...")
    rngs = ranges_data(data)
    exons = data[:,9]
    geneid_exonnumber = map(exon->
                         filter(x->contains(x,"gene_name")||contains(x,"exon_number"),
                                split(exon,";")), exons)

    #@show geneid_exonnumber[1:5]
    
    #return 
    rng_exon_dict = Dict(zip(rngs, geneid_exonnumber))
    #not save it
    #save(rng_exon_dict_fl, "rng_exon_dict", rng_exon_dict)
    info("range exon index saved in $rng_exon_dict_fl")
    #@show collect(rng_exon_dict)[1:5],typeof(rng_exon_dict)
    rng_exon_dict
end

@doc """ return ranges from data
""" ->
function ranges_data(data::Array{ASCIIString,2})
    sts  = data[:,4]
    eds  = data[:,5]
    len  = length(sts)
    rngs = map(i->(sts[i],eds[i]),1:len)
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
            if fields[3] != "exon"
                continue
            end
            if contains(fields[9],"gene_type \"pseudogene\"")
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

