include("../../essential_definitions/evolution.jl")

struct Location
    name::Symbol
    invariant::RectConstraint
    flow::IntervalAssignment
    edges::Vector

    function Location(name::Symbol,
                    invariant::RectConstraint,
                    flow::IntervalAssignment)
        new(name, invariant, flow, [])
    end
end
