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

module HybridGames

using DataStructures, DifferentialEquations, Match

export Agent, Action, Assignment, Valuation, Decision
export Location, Edge, Game, State

include("expression.jl")
include("constraint.jl")

# TODO: add constant documentation
const Agent = Symbol
# TODO: add constant documentation
const Action = Symbol
# TODO: add constant documentation
const Assignment = OrderedDict{Variable, ExprLike}
# TODO: add constant documentation
const Valuation = OrderedDict{Variable, Real}
# TODO: add constant documentation
const Decision = Pair{Agent, Action}

include("evaluation.jl")

#abstract type for locations in games
abstract type Location end
# abstract type for edges in games
abstract type Edge end
# abstract type for games
abstract type Game end
# abstract type for states in games
abstract type State end

include("helper_functions.jl")
include("hgt/hgt.jl")
include("mhg/mhg.jl")

end
