if !in("../src",LOAD_PATH)
    push!(LOAD_PATH,"../src")
end

using GeneMisc
using Base.Test

@test 1 == 1

include("synonym.jl")
#include("location.jl")
#include("exon.jl")
#=
let gene = "KRAS", genesyn = ["KRAS","C-K-RAS","CFC2","K-RAS2A","K-RAS2B",
                              "K-RAS4A","K-RAS4B","KI-RAS","KRAS1","KRAS2",
                              "NS","NS3","RALD","RASK2"]
    
#    @test query_gene("KRAS") == Set(genesyn)

end

let chr="chr20",pos="45314173"
#    @test query_gene(chr,pos) == "TP53RK"
end
=#
