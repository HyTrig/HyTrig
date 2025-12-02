include("helper_functions.jl")

using DifferentialEquations


function continuous_evolution(valuation::Valuation, 
                              flow::ReAssignment,
                              time::Float64)::Valuation

    function flowODE!(du, u, p, t)
        current_valuation = valuation_from_flow_vector(flow, valuation, u)
        for (i, (_, var_flow)) in enumerate(flow)
            # Evaluate the flow for the variable
            du[i] = evaluate(var_flow, current_valuation)
        end
    end

    u0 = Float64[round5(valuation[var]) for (var, _) in flow] 
    tspan = (0.0, time)  # Add a small buffer to ensure we capture the trigger time
    prob = ODEProblem(flowODE!, u0, tspan)
    sol = solve(prob, Tsit5(), abstol=1e-6, reltol=1e-6)
    
    final_valuation = round5(valuation_from_flow_vector(flow, valuation, sol[end]))
    return final_valuation, round5(sol.t[end])
end

function discrete_evolution(valuation::Valuation, 
                            jump::ReAssignment)::Valuation
    new_valuation::Valuation = copy(valuation)
    for (var, expr) in jump
        new_valuation[var] = evaluate(expr, new_valuation)
    end
    return round5(new_valuation)
end