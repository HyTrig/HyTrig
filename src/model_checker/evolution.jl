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

# Shared ODE right-hand side for a flow whose variable derivatives have been
# precompiled into a `Vector{PartialFn}`. `p` carries the constant base valuation
# (`p.full`, in valuation order) and the compiled flow functions (`p.flow_fns`,
# in flow order, matching `u`). `PartialFn` is a concrete type, so the loop is
# type-stable and allocation-free regardless of how many flow variables there are.
function _flow_rhs!(du, u, p, t)
    flow_fns = p.flow_fns
    @inbounds for i in eachindex(flow_fns)
        du[i] = flow_fns[i](p.full, u)
    end
    return nothing
end

# TODO: add function documentation
function discrete_evolution(valuation::Valuation, 
                            jump::Assignment)::Valuation
    new_valuation::Valuation = copy(valuation)
    for (var, expr) in jump
        new_valuation[var] = evaluate(expr, new_valuation)
    end
    return new_valuation
end
