"""TODO: write docs"""

module ModelChecker

using DifferentialEquations, Match, Reexport

include("../hybrid_games/hybrid_games.jl")
@reexport using .HybridGames

include("evaluation.jl")
include("evolution.jl")
include("hgt/hgt_checker.jl")
include("mhg/mhg_checker.jl")

end
