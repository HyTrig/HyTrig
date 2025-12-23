include("location.jl")

struct Edge
    name::Symbol
    start_location::Location
    target_location::Location
    guard::RectConstraint
    decision::Decision
    jump::IntervalAssignment

    function Edge(name::Symbol,
                  start_location::Location,
                  target_location::Location,
                  guard::RectConstraint,
                  decision::Decision,
                  jump::IntervalAssignment)
        new(name, start_location, target_location, guard, decision, jump)
    end
end