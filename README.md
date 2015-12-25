# GeneMisc

Linux, OSX: [![Build Status](https://travis-ci.org/OpenGene/GeneSynonym.jl.svg?branch=master)](https://travis-ci.org/OpenGene/GeneSynonym.jl)

Windows: [![Build status](https://ci.appveyor.com/api/projects/status/4vr88cmgo7u02644/branch/master?svg=true)](https://ci.appveyor.com/project/zhmz90/GeneMisc/branch/master)

Code Coverage: [![Coverage Status](https://coveralls.io/repos/JuliaLang/julia/badge.svg?branch=master)](https://coveralls.io/r/JuliaLang/julia?branch=master) [![codecov.io](http://codecov.io/github/JuliaLang/julia/coverage.svg?branch=master)](http://codecov.io/github/JuliaLang/julia?branch=master)

### Add GeneSynonym
This project has no plan to register in Julia METADATA.jl, so if want to use it, do:

	Pkg.clone("https://github.com/OpenGene/GeneSynonym.jl.git")
	Pkg.build("GeneSynonym")
	
This project is under active developing, if you encountered any troubles, open an issue please.
	
### Examples of Usage

**query a gene for its synonym**

	using GeneMisc
	query_gene("TP53")
	
**query a lot of genes**

	using GeneMisc
	genes = ASCIIString["TP53","KRAS","BRCA"]
	query_gene(genes)

**query a gene given its location**

	using GeneMisc
	chr = "chr1"
	pos = "12235"
	query_gene(chr,pos)
	
**query a lot of genes given their locations**

	using GeneMisc
	chr_pos = ["chr1" "123234";
               "chr2", "21424"]
	query_gene(chr_pos)
