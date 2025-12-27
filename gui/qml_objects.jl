"""
    TODO
"""

mutable struct QAction
    name::String
end

mutable struct QAgent
    name::String
end

mutable struct QVariable
    name::String
    value::String
end

mutable struct QTrigger
    agent::String
    trigger::String
end

mutable struct QLocation
    name::String
    initial::Bool
    invariant::String
    flow::JuliaItemModel
end

function QLocation(name::String, initial::Bool, invariant::String)
    return QLocation(name, initial, invariant, JuliaItemModel([QFlow(v.name, v.name) for v in variable_list]))
end

mutable struct QFlow
    variable::String
    expression::String
end
