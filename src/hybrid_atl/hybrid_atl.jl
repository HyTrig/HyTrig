"""TODO: write docs"""

# TODO: what is ATL?
module HybridATL

using DataStructures, Match

export Logic_Formula, Termination_Conditions, union_safe

abstract type Logic_Formula end

include("expression.jl")
include("constraint.jl")
include("state.jl")
include("strategy.jl")

struct Termination_Conditions
    time_limit::Real
    max_steps::Int64
    state_formula::State_Formula
end

# TODO: type this function
function union_safe(l)
    if isempty(l)
        # Return an empty vector with a specific type if known,
        # or a generic empty vector if not.
        return eltype(l)[] 
    else
        return union(l...)
    end
end

end
