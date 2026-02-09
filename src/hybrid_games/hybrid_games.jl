"""TODO: write docs"""

module HybridGames

using DataStructures, DifferentialEquations, Match

include("../hybrid_atl/hybrid_atl.jl")
using .HybridATL

export Action, Valuation, Decision
export Location, Edge, Game

const Action = Symbol
const Valuation = OrderedDict{Variable, Real}
const Decision = Pair{Agent, Action}

abstract type Location end
abstract type Edge end
abstract type Game end
abstract type State end

include("evaluation.jl")
include("helper_functions.jl")
include("evolution.jl")
include("hgt/hgt.jl")
include("mhg/mhg.jl")

end
