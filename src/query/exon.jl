
function __init__()
    global chr_rngs = load_chr_rngs()
    global rng_exon = load_rng_exon()
end

@doc """ return gene_name, exton_number
index1: chr=>ranges
(1,5) (7,10) (12,16) (18,20)
1 7 12 18
5 10 16 20
odd is st, even is ed.
from odd, find the two numbers surround Q
from even, find the two numbers surround Q
index2: ranges=>exon
""" ->
function query_exon(chr::ASCIIString,pos::ASCIIString,direct::ASCIIString)
    pos = parse(UInt64,pos)
    query_exon(chr,pos,direct)
end
function query_exon(chr::ASCIIString, pos::UInt64, direct::ASCIIString)
    #load index
    rngs_target =  chr_rngs[chr]
    sts_sorted = map(x->x[1],rngs_target)
    eds_sorted = map(x->x[2],rngs_target)
    
    #need to check
    function ret(idx)
        rng = map(x->string(Int64(x)), rngs_target[idx])
        map(x->convert(ASCIIString,x), rng_exon[chr,rng])
    end
    num_rng = length(rngs_target)
    st_idx = searchsortedfirst(sts_sorted, pos)
    ed_idx = searchsortedfirst(eds_sorted, pos)
    if st_idx == 1
        return ret(1)
    end
    if st_idx>num_rng || ed_idx>num_rng
        return ret(st_idx-1)
    end
    st1,st2 = sts_sorted[st_idx-1:st_idx] # bugs here
    if st2 == pos
        return ret(st_idx)
    end
    if ed_idx == 1
        return ret(1)
    end
    ed1,ed2 = eds_sorted[ed_idx-1:ed_idx]
    if ed2 == pos
        return ret(ed_idx)
    end
    #@show pos,st1,st2,ed1,ed2
    if st_idx != ed_idx
        return ret(st_idx-1)
    elseif st_idx == ed_idx
        if direct == "-"
            return ret(st_idx)
        elseif direct == "+"
            return ret(st_idx-1)
        end
    end

    #=
    @assert pos <= st2
    @assert pos <= ed2
    if st1 < pos < ed1
        return rngs_target[st_idx-1]
    elseif st2 < pos < ed2
        error("pos cannot be here")
        return
    elseif ed1<pos<st2
        if direct == "+"
            return rngs_target[st_idx]
        elseif direct == "-"
            return rngs_target[st_idx-1]
        else
            error("direct not detected!")
        end
    end
    =#
    error("unexpected")
end

function load_chr_rngs()
    chr_rngs = build_index_exon()
    #chr_rngs = load(chr_rngs_exon_fl, "chr_rngs_exon_dict")
    chr_rngs
end

function load_rng_exon()
    #load(rng_exon_dict_fl, "rng_exon_dict")
    range_exon_index(read_gtf())
end
