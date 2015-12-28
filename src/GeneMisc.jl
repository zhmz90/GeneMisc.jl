module GeneMisc

# package code goes here

using JLD
using Logging
@Logging.configure(level=INFO)
const data_dir = joinpath(driname(dirname(@__FILE__)), "data")
const hs_fl    = joinpath(data_dir, "Homo_sapiens.gene_info")
const gene_synonym_fl = joinpath(data_dir, "gene_synonym_dict.jld")
const id_genes_fl = joinpath(data_dir, "id_genes_dict.jld")
const gene_id_fl  = joinpath(data_dir, "gene_id_dict.jld")
const genecode_fl = joinpath(data_dir, "gencode.v19.annotation.gtf")
const pos_gene_fl = joinpath(data_dir, "pos_gene_dict.jld")

global id_genes,gene_id,pos_gene

export query_gene


include("genesynonym.jl")
include("genelocation.jl")
include("index.jl")
include("query.jl")

end # module
