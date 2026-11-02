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

# Compute the configurations that matter along the timed evolution from `config`.
# The flow, the query's "zero" expressions and the location's invariant zeros
# were already compiled (once, in `check_query`) into the concretely-typed vectors
# carried by `precompiled`; here they drive the ODE directly, so the right-hand
# side and the event condition are type-stable and allocation-free no matter how
# many expressions are involved.
function essential_configurations(config::Configuration,
                                  precompiled,
                                  remaining_time::Float64,
                                  termination_formula::State_Formula)::Tuple{Configuration, Vector{Configuration}}

    flow_fns = precompiled.flow_fns          # partial closures, driven by `u`
    zero_fns = precompiled.zero_fns          # full closures, depend on the whole valuation
    inv_fns  = precompiled.inv_fns           # full closures, depend on the whole valuation
    flow_to_full = precompiled.flow_to_full  # flow position in `u` -> valuation position

    important_configurations = Configuration[]
    local_clock = 0.0
    full_vals = valuation_to_vector(config.valuation)
    current_full = copy(full_vals)           # reused buffer: current valuation during the flow
    p = (full = full_vals, flow_fns = flow_fns)

    # Event when condition(out, u, t, integrator) == 0; `out` is filled in place
    # with the 5-digit rounded zero expressions followed by the invariant zeros.
    # These are full closures, so the live flow values `u` are first scattered
    # back into `current_full` (only the flow positions change; the rest of the
    # valuation is constant during the flow). The closure captures the compiled
    # vectors directly (not via `integrator.p`, which is type-unstable inside
    # callbacks).
    function condition(out, u, t, integrator)
        @inbounds for k in eachindex(flow_to_full)
            current_full[flow_to_full[k]] = u[k]
        end
        @inbounds for i in eachindex(zero_fns)
            out[i] = round4(zero_fns[i](current_full), 5)
        end
        @inbounds for i in eachindex(inv_fns)
            out[length(zero_fns) + i] = round4(inv_fns[i](current_full), 5)
        end
        return nothing
    end

    function affect!(integrator, idx)
        # entry config is already evaluated by the caller; never re-record events at (rounded) t=0
        if round(integrator.t, digits=5) == local_clock
            return
        end
        local_clock = round(integrator.t, digits=5)
        current_valuation = valuation_from_flow_vector(config.location.flow, config.valuation, integrator.u)
        current_config = Configuration(config.location, current_valuation, config.global_clock + round(integrator.t, digits=5))
        if ! evaluate(config.location.invariant, current_valuation) || evaluate_state(termination_formula, current_config, false)
            terminate!(integrator) # Stop the integration when the condition is met
            return
        end
        push!(important_configurations, current_config)
    end

    cbv = VectorContinuousCallback(condition, affect!, length(zero_fns) + length(inv_fns))

    u0 = Float64[config.valuation[var] for (var, _) in config.location.flow]
    tspan = (0.0, remaining_time + 1e-5)  # Add a small buffer to ensure we capture the trigger time
    prob = ODEProblem(_flow_rhs!, u0, tspan, p)
    sol = solve(prob, Tsit5(), callback=cbv, abstol=1e-6, reltol=1e-6, maxiters=10^6)

    final_valuation = valuation_from_flow_vector(config.location.flow, config.valuation, sol.u[end])
    final_config = Configuration(config.location, final_valuation, config.global_clock + round4(sol.t[end], 5))
    return final_config, important_configurations
end
