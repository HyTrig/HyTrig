"""TODO: write docs"""

module HybridGames

using DataStructures, DifferentialEquations, Match

include("../hybrid_atl/hybrid_atl.jl")
@reexport using .HybridATL
import .HybridATL: round5, to_string

export Action, Assignment, Valuation, Decision
export Location, Edge, Game, State

const Action = Symbol
const Assignment = OrderedDict{Variable, ExprLike}
const Valuation = OrderedDict{Variable, Real}
const Decision = Pair{Agent, Action}

abstract type Location end
abstract type Edge end
abstract type Game end
abstract type State end

include("helper_functions.jl")
include("hgt/hgt.jl")
include("mhg/mhg.jl")

end
