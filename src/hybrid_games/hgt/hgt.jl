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

export HGT_Location, HGT_Edge, HGT_Game

# TODO: add type documentation
struct HGT_Location <: Location
    name::Symbol
    invariant::Constraint
    flow::Assignment
    edges::Vector

    function HGT_Location(name::Symbol,
                    invariant::Constraint,
                    flow::Assignment)
        filtered_flow::Assignment = OrderedDict()
        for (var, val) in flow
            if val != Const(0.0)
                filtered_flow[var] = val
            end
        end
        new(name, invariant, filtered_flow, [])
    end
end

# TODO: add type documentation
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

# TODO: add type documentation
struct HGT_Game <: Game
    locations::Vector{HGT_Location}
    initial_location::HGT_Location
    initial_valuation::Valuation
    agents:: Vector{Agent}
    actions::Vector{Action}
    edges:: Vector{HGT_Edge}
    triggers:: Dict{Agent, Vector{Constraint}}

    function HGT_Game(locations::Vector{HGT_Location}, 
                    initial_location::HGT_Location, 
                    initial_valuation::Valuation, 
                    agents::Vector{Agent}, 
                    actions::Vector{Action},
                    edges::Vector{HGT_Edge},
                    triggers:: Dict{Agent, Vector{Constraint}})::HGT_Game

        for edge in edges
            push!(edge.start_location.edges, edge)
        end

        new(locations, 
            initial_location, 
            initial_valuation, 
            agents, 
            actions, 
            edges, 
            triggers)
    end
end

include("configuration.jl")
