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

# TODO: add type documentation
struct TriggerPath
    trigger::Constraint
    end_valuation::Valuation
    ttt::Float64
    path_to_trigger::Vector{Configuration}
end

function time_to_trigger(config::Configuration, constraints::Set{Constraint}, max_time::Float64)

    constraints_val = Dict(constr => evaluate(constr, config.valuation) for constr in constraints)

    zero_constraints::Set{ExprLike} = get_zero(constraints)
    zero_invariant::Set{ExprLike} = get_zero(config.location.invariant)

    path_to_trigger::Vector{Configuration} = Vector()
    
    function flowODE!(du, u, p, t)
        current_valuation = valuation_from_flow_vector(config.location.flow, config.valuation, u)
        for (i, (_, var_flow)) in enumerate(config.location.flow)
            # Evaluate the flow for the variable
            du[i] = evaluate(var_flow, current_valuation)
        end
    end

    function condition(out, u, t, integrator) # Event when condition(out,u,t,integrator) == 0
        current_valuation = valuation_from_flow_vector(config.location.flow, config.valuation, u)
        for (i, zero_constr) in enumerate(zero_constraints)
            out[i] = round5(evaluate(zero_constr, current_valuation))
        end
        for (i, zero_invr) in enumerate(zero_invariant)
            out[length(zero_constraints) + i] = round5(evaluate(zero_invr, current_valuation), 6)
        end
    end

    function affect!(integrator, idx)
        if round5(integrator.t, 6) == 0.0
            return # No need to affect the valuation if the trigger was already met at time 0
        end
        current_valuation = round5(valuation_from_flow_vector(config.location.flow, config.valuation, integrator.u), 6)
        if ! evaluate(config.location.invariant, current_valuation)
            terminate!(integrator) # Stop the integration when the condition is met
            return
        end
        # if get_exact(config.location.invariant, current_valuation)
        #     push!(path_to_trigger, current_config)
        #     return
        # end
        current_valuation = round5(current_valuation)
        if any(zero_constr -> evaluate(zero_constr, current_valuation) == 0.0, zero_constraints) && 
           any(constr -> evaluate(constr, current_valuation) != constraints_val[constr], constraints)
            push!(path_to_trigger, Configuration(config.location, current_valuation, config.global_clock + round5(integrator.t)))
            for constr in constraints
                constraints_val[constr] = evaluate(constr, current_valuation)
            end
        end
    end

    cbv = VectorContinuousCallback(condition, affect!, length(zero_constraints) + length(zero_invariant))

    u0 = Float64[round5(config.valuation[var]) for (var, _) in config.location.flow] 
    tspan = (0.0, max_time + 1e-6)  # Add a small buffer to ensure we capture the trigger time
    prob = ODEProblem(flowODE!, u0, tspan)
    sol = solve(prob, Tsit5(), callback=cbv, abstol=1e-6, reltol=1e-6)
    
    final_valuation = round5(valuation_from_flow_vector(config.location.flow, config.valuation, sol[end]))
    final_config = Configuration(config.location, final_valuation, config.global_clock + round5(sol.t[end]))
    return final_config, path_to_trigger
end
