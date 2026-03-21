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

# TODO: add function documentation
function discrete_transition(start_config::Configuration, edge::Edge)::Configuration
    Configuration(edge.target_location, 
                  discrete_evolution(start_config.valuation, edge.jump),
                  start_config.global_clock
                 )
end

# TODO: add function documentation
function enabled(edge::HGT_Edge, valuation::Valuation)::Bool
    return evaluate(edge.guard, valuation) && evaluate(edge.target_location.invariant, discrete_evolution(valuation, edge.jump))
end

# TODO: add function documentation
function select_edges(config, decision::Decision)::Vector{HGT_Edge}
    selected_edges = HGT_Edge[]
    for edge in config.location.edges
        if edge.decision == decision && enabled(edge, config.valuation) 
            push!(selected_edges, edge)
        end
    end
    return selected_edges
end
