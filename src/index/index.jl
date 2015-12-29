
include("synonym.jl")
include("location.jl")

@doc """ build index for genes
""" ->
function build_index()

    info("Building index now")
    @sync begin
        @spawn build_index_synonym()
        @spawn build_index_geneloc()
    end
    info("Building index done")
    true
end

@doc """ load index for synonym genes
""" ->
function load_index()
    if isfile(id_genes_fl) || isfile(gene_id_fl)  || isfile(chrsted_gene_fl)
        build_index()
    end
    
    global id_genes = load(id_genes_fl, "id_genes_dict")
    global gene_id  = load(gene_id_fl,  "gene_id_dict")
    global chr_sted_gene = load(chr_sted_gene_fl, "chr_sted_gene_dict")
    global gene_chrsted  = load(gene_chrsted, "gene_chrsted_dict")
    gene_id,id_genes,chr_sted_gene,gene_chrsted
end


