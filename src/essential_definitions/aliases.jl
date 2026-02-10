using DataStructures

const Agent = Symbol
const Action = Symbol
const Variable = Symbol
const Valuation = OrderedDict{Variable, Real}
const Decision = Pair{Agent, Action}

const Container{T} = Union{AbstractVector{T}, AbstractSet{T}}


function round5(num::Real)::Real
    return round(num, digits=5)
end