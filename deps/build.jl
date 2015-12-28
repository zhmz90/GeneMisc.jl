
using JLD

const data_dir = joinpath(dirname(@__FILE__), "data")
const hs_fl    = joinpath(data_dir, "Homo_sapiens.gene_info")
const gene_synonym_fl = joinpath(data_dir, "gene_synonym_dict.jld")
const id_genes_fl = joinpath(data_dir, "id_genes_dict.jld")
const gene_id_fl  = joinpath(data_dir, "gene_id_dict.jld")
const genecode_fl = joinpath(data_dir, "gencode.v19.annotation.gtf")
const pos_gene_fl = joinpath(data_dir, "pos_gene_dict.jld")

include("../src/genelocation.jl")
include("../src/genesynonym.jl")
include("../src/index.jl")


build_index()
