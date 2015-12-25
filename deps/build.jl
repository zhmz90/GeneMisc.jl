
using JLD

const data_dir = "../data"
const hs_fl    = joinpath(data_dir, "Homo_sapiens.gene_info")
const gene_synonym_fl = joinpath(data_dir, "gene_synonym_dict.jld")
const id_genes_fl = joinpath(data_dir, "id_genes_dict.jld")
const gene_id_fl  = joinpath(data_dir, "gene_id_dict.jld")
const genecode_fl = joinpath(data_dir, "gencode.v19.annotation.gtf")
const pos_gene_fl = joinpath(data_dir, "pos_gene_dict.jld")

include("../src/genelocation.jl")

build_index()

@doc """ read data from Homo_sapiens.gene_info
""" ->
function read_data()
    if !isdir(data_dir)
        mkdir(data_dir)
    end 
    if !isfile(hs_fl)
        cmd = `wget ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz`
        rum(cmd)
        run(`gunzip $string(hs_fl,".gz")`)
    end
    @assert isfile(hs_fl)
    data = readdlm(hs_fl, ASCIIString)
end

@doc """ get gene name and its synonym from data,
         save it to file, and return it
""" ->
function genename_synonym(data::Array{ASCIIString,2})
    num_gene = size(data,1)
    genenames = data[:,3]
    synonyms  = map(x->map(y->convert(ASCIIString,y), split(x,"|")), data[:,5])

    id_genes = Dict{Int64, Set{ASCIIString}}()
    for i = 1:num_gene
        id_genes[i] = Set(vcat(genenames[i], synonyms[i]))
    end
    save(id_genes_fl, "id_genes_dict", id_genes)
    
    genes_id_pair = map(reverse, collect(id_genes))
    gene_id = Dict{ASCIIString,Int64}()
    for i = 1:num_gene
        samplegenes = genes_id_pair[i][1]
        id          = genes_id_pair[i][2]
        num_samplegene = length(samplegenes)
        for j = 1:num_samplegene
            genename = samplegenes[j]
            gene_id[genename] = id
        end
    end
    save(gene_id_fl, "gene_id_dict", gene_id)

    nothing
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
