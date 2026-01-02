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

function QLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)::QLocation
    return QLocation(name, invariant, initial, JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow]))
end

function setflow!(location_model::Vector{QLocation}, flow::AbstractArray, row::Int32, col::Int64)
    location_model[row].flow = JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow])
end

mutable struct QFlow
    variable::String
    expression::String
end

mutable struct QEdge
    source::String
    target::String
    guard::String
    jump::JuliaItemModel
end

function QEdge(source::String, target::String, guard::String, jump::AbstractArray)::QEdge
    return QEdge(source, target, guard, JuliaItemModel([QJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump]))
end

function setjump!(edge_model::Vector{QEdge}, jump::AbstractArray, row::Int32, col::Int64)
    edge_model[row].jump = JuliaItemModel([QJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump])
end

mutable struct QJump
    variable::String
    expression::String
end

mutable struct QQuery
    formula::String
end
