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

module HyTrig

using DataStructures, JSON3, Match, Reexport

include("model_checker/model_checker.jl")
@reexport using .ModelChecker
export evaluate_queries

include("parser/parser.jl")
@reexport using .Parser
using .Parser: parse

include("game_parser/game_parser.jl")

end
