"""TODO: write docs"""

module HyTrig

using DataStructures, JSON3, Match

include("model_checker/model_checker.jl")
using .ModelChecker

export evaluate_queries

include("parser/parser.jl")
using .Parser
using .Parser: parse

include("game_parser/game_parser.jl")

end
