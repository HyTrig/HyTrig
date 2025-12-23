include("edge.jl")

struct Game
    locations::Vector{Location}
    initial_location::Location
    initial_valuation::Valuation
    agents:: Vector{Agent}
    actions::Vector{Action}
    edges:: Vector{Edge}
    triggers:: Dict{Agent, Vector{Constraint}}

    function Game(  locations::Vector{Location}, 
                    initial_location::Location, 
                    initial_valuation::Valuation, 
                    agents::Vector{Agent}, 
                    actions::Vector{Action},
                    edges::Vector{Edge},
                    triggers:: Dict{Agent, Vector{Constraint}})::Game

        """ First edge in each location is a stutter edge that allows the game 
            to stay in the same location without making any changes. """

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