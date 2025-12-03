include("../essential_definitions/evolution.jl")

struct Location
    name::Symbol
    invariant::Constraint
    flow::ReAssignment
    edges::Vector

    function Location(name::Symbol,
                    invariant::Constraint,
                    flow::ReAssignment)

        filtered_flow::ReAssignment = OrderedDict()
        for (var, val) in flow
            if val != Const(0.0)
                filtered_flow[var] = val
            end
        end
        new(name, invariant, filtered_flow, [])
    end
end
