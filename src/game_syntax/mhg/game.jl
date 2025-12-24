include("edge.jl")

struct MHG_Game <: Game
    locations::Vector{MHG_Location}
    initial_location::MHG_Location
    initial_valuation::IntervalAssignment
    agents:: Vector{Agent}
    actions::Vector{Action}
    edges:: Vector{MHG_Edge}

    function MHG_Game(  locations::Vector{MHG_Location}, 
                    initial_location::MHG_Location, 
                    initial_valuation::IntervalAssignment, 
                    agents::Vector{Agent}, 
                    actions::Vector{Action},
                    edges::Vector{MHG_Edge})::MHG_Game

        for edge in edges
            push!(edge.start_location.edges, edge)
        end

        new(locations, 
            initial_location, 
            initial_valuation, 
            agents, 
            actions, 
            edges)
    end
end