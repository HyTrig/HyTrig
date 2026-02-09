"""TODO: write docs"""

export round5, valuation_from_vector, valuation_from_flow_vector

function round5(valuation::Valuation)::Valuation
    new_valuation::OrderedDict{Symbol, Real} = OrderedDict()
    for (var, value) in valuation
        new_valuation[var] = round5(value)
    end
    return new_valuation
end

function valuation_from_vector(valuation::Valuation, vector::Vector{Real})::Valuation
    new_valuation::OrderedDict{Symbol, Real} = OrderedDict()
    for (i, (var, _)) in enumerate(valuation)
        new_valuation[var] = vector[i]
    end
    return new_valuation
end

function valuation_from_flow_vector(flow:: Assignment, valuation::Valuation, vector::Vector{Real})::Valuation
    new_valuation::OrderedDict{Symbol, Real} = OrderedDict()
    i = 1
    for (var, value) in valuation
        if !(var in keys(flow))
            new_valuation[var] = value
        else 
            new_valuation[var] = vector[i]
            i += 1
        end
    end
    return new_valuation
end
