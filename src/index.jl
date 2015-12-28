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

@doc """ build index for genes
""" ->
function build_index()
    #for id_genes,gene_id
    #data = read_data()
    @sync begin
        @spawnat 2 genename_synonym(read_data())
    #info("build_pos_gene beginning")
        #for pos_gene
        build_pos_gene()
    end

    true
end

