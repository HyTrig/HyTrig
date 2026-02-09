include("../abstract_syntax.jl")
include("../../essential_definitions/evolution.jl")

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
