module GeneMisc

#using ParallelAccelerator
using JLD

const data_dir = joinpath(dirname(dirname(@__FILE__)), "data")
const hs_fl    = joinpath(data_dir, "Homo_sapiens.gene_info")
const genecode_fl = joinpath(data_dir, "gencode.v19.annotation.gtf")

#index files

### synonym index
const gene_id_fl  = joinpath(data_dir, "gene_id_dict.jld")
const id_genes_fl = joinpath(data_dir, "id_genes_dict.jld")

### location index
const chr_sted_gene_fl = joinpath(data_dir, "chr_sted_gene_dict.jld")
const gene_chrsted_fl  = joinpath(data_dir, "gene_chrsted.jld")

### exon index

global id_genes,gene_id,chr_sted_gene,gene_chrsted

export query_gene, query_geneloc, query_exon

function __init__()
    load_index()
end

include("utils/utils.jl")
include("index/index.jl")
include("query/query.jl")

end # module
