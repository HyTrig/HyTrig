"""
    HyTrig
    
This module provides all features of the HyTrig tool.

# Authors:
- Moritz Maas
"""

module HyTrig

using DataStructures, JSON3, Match, Reexport

include("model_checker/model_checker.jl")
@reexport using .ModelChecker

include("parser/parser.jl")
@reexport using .Parser
using .Parser: parse

include("game_parser/game_parser.jl")

end
