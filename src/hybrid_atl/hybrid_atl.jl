"""TODO: write docs"""

module HybridATL

using DataStructures, Match, Reexport

include("../hybrid_games/hybrid_games.jl")
@reexport using .HybridGames
import .HybridGames: round5, to_string

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
