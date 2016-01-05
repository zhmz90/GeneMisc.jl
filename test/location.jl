
let gene="ABL1"
    @test query_geneloc(gene) == ("chr9", "133589333", "133763062")
end

let gene = "TNFRSF14"
    @test query_gene("chr1","2490013") == "TNFRSF14"
end
