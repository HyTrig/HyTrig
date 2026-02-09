"""TODO: write docs"""

export MHG_Location, MHG_Edge, MHG_Game

include("interval.jl")

struct MHG_Location <: Location
    name::Symbol
    invariant::RectConstr
    flow::IntervalAssignment
    edges::Vector

    function MHG_Location(name::Symbol,
                    invariant::RectConstr,
                    flow::IntervalAssignment)::MHG_Location
        new(name, invariant, flow, [])
    end
end

struct MHG_Edge <: Edge
    name::Symbol
    start_location::MHG_Location
    target_location::MHG_Location
    guard::RectConstr
    decision::Decision
    jump::IntervalAssignment
end

struct MHG_Game <: Game
    locations::Vector{MHG_Location}
    initial_location::MHG_Location
    initial_valuation::IntervalAssignment
    agents::Vector{Agent}
    actions::Vector{Action}
    edges::Vector{MHG_Edge}

    function MHG_Game(locations::Vector{MHG_Location},
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

include("zone.jl")
