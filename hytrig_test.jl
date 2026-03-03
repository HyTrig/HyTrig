"""
    HyTrig Test

This script runs all tests for the HyTrig project.

# Authors:
- Moritz Maas
"""

using Pkg

Pkg.activate(".")
Pkg.instantiate()

using Test

@testset verbose = true "HyTrig Tests" begin

include("test/test_tokenizer.jl")
include("test/test_formula_parser.jl")
include("test/test_parser.jl")

end
