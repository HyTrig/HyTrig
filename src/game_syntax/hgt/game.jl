include("edge.jl")

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