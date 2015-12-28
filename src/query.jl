

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

