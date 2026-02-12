"""TODO: write docs"""

module HybridGames

using DataStructures, DifferentialEquations, Match

export Agent, Action, Assignment, Valuation, Decision
export Location, Edge, Game, State

include("expression.jl")
include("constraint.jl")

const Agent = Symbol
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
