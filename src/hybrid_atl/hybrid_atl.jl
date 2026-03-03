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

module HybridATL

using DataStructures, Match, Reexport

include("../hybrid_games/hybrid_games.jl")
@reexport using .HybridGames
import .HybridGames: round5

export Logic_Formula, Termination_Conditions, union_safe

abstract type Logic_Formula end

include("state.jl")
include("strategy.jl")

struct Termination_Conditions
    time_limit::Real
    max_steps::Int64
    state_formula::State_Formula
end

end
