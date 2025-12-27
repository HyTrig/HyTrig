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

function QLocation(name, inv, initial, flow::AbstractArray)::QLocation
    return QLocation(name, inv, initial, JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow]))
end

function setflow!(location_model, flow, row, col)
    location_model[row].flow = JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow])
end

mutable struct QFlow
    variable::String
    expression::String
end
