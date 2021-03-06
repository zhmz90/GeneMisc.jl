
@doc """  if pos_gene have this position, return gene; else return ""
          Foundational function
""" ->
function query_gene(chr::ASCIIString,pos::Int64)
    info("query_gene for a $chr,$pos")
    if !isdefined(GeneMisc,:chr_sted_gene)
        warn("chr_sted_gene is not defined,load_index starts")
        load_index()
    end
    sted_gene = chr_sted_gene[chr]
    
    steds = collect(keys(sted_gene))
    # sorted by acclerator speed
    starts = sort(map(x->x[1], steds))
    ends   = sort(map(x->x[2], steds))
    debug = true
    function check_sted(starts,ends)
        l = length(starts)
        @assert length(ends) == l
        for i in 1:l
            @assert starts[i] < ends[i]
        end
    end
    if debug check_sted(starts,ends) end
    idx_st = searchsortedfirst(starts, pos)
    idx_ed = searchsortedfirst(ends, pos)
    function result(st_idx,ed_idx)
        info("$st_idx, $ed_idx")
        st = starts[st_idx]
        ed = ends[ed_idx]
        sted_gene[(st,ed)]
    end
    if idx_st == 1
        if starts[1] < pos
            return ""
        end
        @assert starts[1] >= pos
        return result(1,1)
    end
    if idx_st == idx_ed
        #if ends[idx_ed] > pos
        return ""
        #end
        #return result(idx_st)
    else
        @assert idx_st > idx_ed
        return result(idx_st-1,idx_ed)
    end
    
    #=
    for (st,ed) in steds
        if st<=pos<=ed
            return sted_gene[(st,ed)]
        end
    end
    =#
    
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
    info("query gene location for you ...")
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
    if !isdefined(GeneMisc, :gene_chrsted)
        load_index()
    end
    gene_chrsted[genename]
end
