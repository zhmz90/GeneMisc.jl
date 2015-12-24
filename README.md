# GeneSynonym

[![Build Status](https://travis-ci.org/OpenGene/GeneSynonym.jl.svg?branch=master)](https://travis-ci.org/OpenGene/GeneSynonym.jl)

### Add GeneSynonym
This project has no plan to register in Julia METADATA.jl, so if want to use it, do:

	Pkg.clone("https://github.com/OpenGene/GeneSynonym.jl.git")
	Pkg.build("GeneSynonym")
	
This project is under active developing, if you encountered any troubles, open an issue please.
	
### Examples of Usage

**query a gene for its synonym**

	using GeneSynonym
	query_gene("TP53")
	
**query a lot of genes**

	using GeneSynonym
	genes = ASCIIString["TP53","KRAS","BRCA"]
	query_gene(genes)
