"""
TODO: document this file by filling out the form below

    File Name
    
File description.

# Types:
- `MyType`: Description of MyType.

# Constants:
- `my_constant::Int`: Description of my_constant.

# Functions:
- `foo(x::String)::Bool`: Do foo.

# Global variables:
- `my_global_variable::Int`: Description of my_global_variable.

# Authors:
- Author 1
- Author 2
"""

module ModelChecker

using DifferentialEquations, Match, Reexport

include("../hybrid_atl/hybrid_atl.jl")
@reexport using .HybridATL

include("evaluation.jl")
include("evolution.jl")
include("hgt/hgt_checker.jl")
include("mhg/mhg_checker.jl")

end
