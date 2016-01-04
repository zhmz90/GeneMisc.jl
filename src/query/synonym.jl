
@doc """ query a gene's synonym including itself with a gene name
""" ->
function query_gene(genename::ASCIIString)
    if !isdefined(GeneMisc, :gene_id) || !isdefined(GeneMisc,:id_genes)
        load_index()
    end
    id_genes[gene_id[genename]]
end

@doc """ query synonym for genes
""" ->
function query_gene(genenames::Array{ASCIIString,1})
    Dict(zip(genenames, map(query_gene, genenames)))
end
