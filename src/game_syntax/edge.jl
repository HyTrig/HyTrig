include("location.jl")

struct Edge
    name::Symbol
    start_location::Location
    target_location::Location
    guard::Constraint
    decision::Decision
    jump::ReAssignment

    function Edge(name::Symbol,
                  start_location::Location,
                  target_location::Location,
                  guard::Constraint,
                  decision::Decision,
                  jump::ReAssignment)

        filtered_jump::ReAssignment = OrderedDict()
        for (var, val) in jump
            if val != Var(var)
                filtered_jump[var] = val
            end
        end
        new(name, start_location, target_location, guard, decision, filtered_jump)
    end
end

function enabled(edge::Edge, valuation::Valuation)::Bool
    return evaluate(edge.guard, valuation) && evaluate(edge.target_location.invariant, discrete_evolution(valuation, edge.jump))
end

function select_initial_edges(edges, config, decision::Decision)::Vector{Edge}
    selected_edges = Vector{Edge}()
    for edge in edges
        if edge.target_location == config.location && edge.decision == decision && enabled(edge, config.valuation) 
            push!(selected_edges, edge)
        end
    end
    return selected_edges
end

function select_edges(config, decision::Decision)::Vector{Edge}
    selected_edges = Vector{Edge}()
    for edge in config.location.edges
        if edge.decision == decision && enabled(edge, config.valuation) 
            push!(selected_edges, edge)
        end
    end
    return selected_edges
end