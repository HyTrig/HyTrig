include("../essential_definitions/evolution.jl")

struct Location
    name::Symbol
    invariant::Constraint
    flow::ReAssignment
    edges::Vector

    function Location(name::Symbol,
                    invariant::Constraint,
                    flow::ReAssignment)
        new(name, invariant, flow, [])
    end
end
