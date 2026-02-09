using DataStructures

const Agent = Symbol
const Action = Symbol
const Variable = Symbol
const Valuation = OrderedDict{Variable, Real}
const Decision = Pair{Agent, Action}


function round5(num::Real)::Real
    return round(num, digits=5)
end