include("location.jl")

struct HGT_Edge <: Edge
    name::Symbol
    start_location::HGT_Location
    target_location::HGT_Location
    guard::Constraint
    decision::Decision
    jump::Assignment

    function HGT_Edge(name::Symbol,
                  start_location::HGT_Location,
                  target_location::HGT_Location,
                  guard::Constraint,
                  decision::Decision,
                  jump::Assignment)
        filtered_jump::Assignment = OrderedDict()
        for (var, val) in jump
            if val != Var(var)
                filtered_jump[var] = val
            end
        end
        new(name, start_location, target_location, guard, decision, filtered_jump)
    end
end

function enabled(edge::HGT_Edge, valuation::Valuation)::Bool
    return evaluate(edge.guard, valuation) && evaluate(edge.target_location.invariant, discrete_evolution(valuation, edge.jump))
end

function select_edges(config, decision::Decision)::Vector{HGT_Edge}
    selected_edges = Vector{HGT_Edge}()
    for edge in config.location.edges
        if edge.decision == decision && enabled(edge, config.valuation) 
            push!(selected_edges, edge)
        end
    end
    return selected_edges
end