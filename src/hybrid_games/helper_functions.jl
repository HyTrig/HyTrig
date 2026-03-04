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

export round5, valuation_from_vector, valuation_from_flow_vector, union_safe

# TODO: add function documentation
function round5(valuation::Valuation)::Valuation
    new_valuation::OrderedDict{Symbol, Real} = OrderedDict()
    for (var, value) in valuation
        new_valuation[var] = round5(value)
    end
    return new_valuation
end

# TODO: add function documentation
function valuation_from_vector(valuation::Valuation, vector::Vector{Real})::Valuation
    new_valuation::OrderedDict{Symbol, Real} = OrderedDict()
    for (i, (var, _)) in enumerate(valuation)
        new_valuation[var] = vector[i]
    end
    return new_valuation
end

# TODO: add function documentation
function valuation_from_flow_vector(flow:: Assignment, valuation::Valuation, vector::Vector{<:Real})::Valuation
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

# TODO: add function documentation
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
