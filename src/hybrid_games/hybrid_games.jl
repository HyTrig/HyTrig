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

const Agent = Symbol
const Action = Symbol
const Assignment = OrderedDict{Variable, ExprLike}
const Valuation = OrderedDict{Variable, Real}
const Decision = Pair{Agent, Action}

include("evaluation.jl")

abstract type Location end
abstract type Edge end
abstract type Game end
abstract type State end

include("helper_functions.jl")
include("hgt/hgt.jl")
include("mhg/mhg.jl")

end
