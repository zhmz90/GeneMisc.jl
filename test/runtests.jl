using GeneMisc
using Base.Test

# write your own tests here
@test 1 == 1

let gene = "KRAS", genesyn = ["KRAS","C-K-RAS","CFC2","K-RAS2A","K-RAS2B",
                              "K-RAS4A","K-RAS4B","KI-RAS","KRAS1","KRAS2",
                              "NS","NS3","RALD","RASK2"]
    @test query_gene("KRAS") == Set(genesyn)

end
