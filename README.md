# GeneMisc

[![Build Status](https://travis-ci.org/OpenGene/GeneMisc.jl.svg?branch=master)](https://travis-ci.org/OpenGene/GeneMisc.jl) 
[![Build Status](https://ci.appveyor.com/api/projects/status/fve72oqy74jm3hmr/branch/master?svg=true)](https://ci.appveyor.com/project/zhmz90/genemisc-jl/branch/master)
[![Coverage Status](https://coveralls.io/repos/OpenGene/GeneMisc.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/OpenGene/GeneMisc.jl?branch=master)
[![Documentation Status](http://readthedocs.org/projects/genemiscjl/badge/?version=latest)](http://genemiscjl.readthedocs.org/en/latest/?badge=latest)


This project is under active developing, if you encountered any troubles, open an issue please.

I am refactoring this package now, any suggestion is more than welcome.

### What can GeneMisc do now?
* Given a location,  find gene.
* Given a location,  find nearest gene name and exon number.

* Given a gene nane, find its location.
* Given a gene name, find its synonyms genes, but the synonyms genes may not complete due to the limitation of our data.


### Add GeneMisc

	Pkg.clone("https://github.com/OpenGene/GeneMisc.jl.git")
	Pkg.build("GeneMisc")
	Pkg.test("GeneMisc")
	


For more information, please refer to the [documentation](http://genemiscjl.readthedocs.org/en/latest/).

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
