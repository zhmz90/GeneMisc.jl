# GeneMisc

This package will be ready for users in a few days.

Given a gene name, find its synonyms genes.

Given a gene nane, find its location.

Given a location,  find gene.

Linux, OSX: [![Build Status](https://travis-ci.org/OpenGene/GeneMisc.jl.svg?branch=master)](https://travis-ci.org/OpenGene/GeneMisc.jl)

### Add GeneMisc
This project has no plan to register in Julia METADATA.jl, so if want to use it, do:

	Pkg.clone("https://github.com/OpenGene/GeneMisc.jl.git")
	Pkg.build("GeneMisc")
	Pkg.test("GeneMisc")
	
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
