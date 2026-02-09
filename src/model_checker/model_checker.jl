"""TODO: write docs"""

module ModelChecker

using DifferentialEquations, Match

include("../hybrid_games/hybrid_games.jl")
using .HybridGames
using .HybridGames.HybridATL

include("hgt/hgt_checker.jl")
include("mhg/mhg_checker.jl")

end
