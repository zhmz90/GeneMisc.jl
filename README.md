# GeneMisc
[![Build Status](https://travis-ci.org/OpenGene/GeneMisc.jl.svg?branch=master)](https://travis-ci.org/OpenGene/GeneMisc.jl) 
[![Documentation Status](https://readthedocs.org/projects/genemiscjl/badge/?version=latest)](http://genemiscjl.readthedocs.org/en/latest/?badge=latest)

### What GeneMisc can do now?
* Given a location,  find gene.
* Given a gene nane, find its location.
* Given a gene name, find its synonyms genes.



### Add GeneMisc

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
