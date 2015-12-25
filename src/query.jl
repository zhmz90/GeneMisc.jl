@doc """ load index for synonym genes
""" ->
function load_index()
    if isfile(id_genes_fl) || isfile(gene_id_fl)
        build_index()
    end
    global id_genes = load(id_genes_fl, "id_genes_dict")
    global gene_id  = load(gene_id_fl,  "gene_id_dict")
    global pos_gene = load(pos_gene_fl, "pos_gene_dict")
    gene_id,id_genes,pos_gene
end

@doc """ query a gene's synonym including itself with a gene name
""" ->
function query_gene(genename::ASCIIString)
    id_genes[gene_id[genename]]
end

@doc """ query synonym for genes
""" ->
function query_gene(genenames::Array{ASCIIString,1})
    map(query_gene, genenames)
end

@doc """  if pos_gene have this position, return gene; else return ""
""" ->
function query_gene(chr::ASCIIString,pos::Int64)
    if in((chr,pos),keys(pos_gene))
        return pos_gene[(chr,pos)]
    end
    ""
end
@doc """ if pos_gene have this position, return gene; else return ""
""" ->
function query_gene(chr::ASCIIString,pos::ASCIIString)
    pos_int = parse(Int64,pos)
    query_gene(chr,pos_int)
end

@doc """ query a lot of positions 
""" ->
function query_gene(data::Array{ASCIIString,2})
    @assert size(data,2) == 2
    n = size(data,1)
    genes = Array{ASCIIString,1}(n)
    for i = 1:n
        chr,pos = data[i,:]
        genes[i] = query_gene(chr,pos)
    end
    genes
end


@doc """ build index for genes
""" ->
function build_index()
    #for id_genes,gene_id
    data = read_data()
    genename_synonym(data)

    #for pos_gene
    build_pos_gene()

    true
end
