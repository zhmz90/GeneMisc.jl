
@doc """  if pos_gene have this position, return gene; else return ""
""" ->
function query_gene(chr::ASCIIString,pos::Int64)
    chrsteds = sort(keys(chrsted_gene))
    if in((chr,pos), )
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

@doc """ Given a gene name, find its location: chr, st, ed
""" ->
function query_geneloc(genename::ASCIIString)

    
end
