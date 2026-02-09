include("../abstract_syntax.jl")
include("../../essential_definitions/evolution.jl")

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
