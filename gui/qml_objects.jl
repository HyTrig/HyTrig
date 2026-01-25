"""
    QML Objects

This file defines the QML objects used in the HyTrig GUI.

# Types:
- `QAction`: Represents an action in a hybrid game.
- `QAgent`: Represents an agent in a hybrid game.
- `QVariable`: Represents a variable in a hybrid game.
- `QTrigger`: Represents a trigger in a hybrid game.
- `QLocation`: Represents a location in a hybrid game.
- `QFlow`: Represents a flow in a location.
- `QEdge`: Represents an edge in a hybrid game.
- `QJump`: Represents a jump in an edge.
- `QQuery`: Represents a query in a hybrid game.
TODO

# Authors:
- Moritz Maas
"""

using JSON3, StructTypes

"""
    QAction

An action in a hybrid game.

    QAction(name::String)

Create a new action with the given name.
"""
mutable struct QAction
    name::String
end

function QAction()::QAction
    return QAction("")
end

"""
    QAgent

An agent in a hybrid game.

    QAgent(name::String)

Create a new agent with the given name.
"""
mutable struct QAgent
    name::String
end

function QAgent()::QAgent
    return QAgent("")
end

"""
    QVariable

A variable in a hybrid game.

    QVariable(name::String, expression::String)

Create a new variable with the given name and expression.
"""
mutable struct QVariable
    name::String
    expression::String
end

function QVariable()::QVariable
    return QVariable("", "")
end

"""
    QTrigger

A trigger in a hybrid game.

    QTrigger(agent::String, trigger::String)

Create a new trigger with the given agent and trigger.
"""
mutable struct QTrigger
    agent::String
    trigger::String
end

function QTrigger()::QTrigger
    return QTrigger("", "")
end

"""
    QLocation

A location in a hybrid game.
"""
mutable struct QLocation
    name::String
    initial::Bool
    invariant::String
    flow::JuliaItemModel
end

function QLocation()::QLocation
    return QLocation("", true, "", JuliaItemModel(QFlow[]))
end

"""
    QLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)

Create a new location with the given name, invariant, initial flag, and flow.
"""
function QLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)::QLocation
    return QLocation(name, invariant, initial, JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow]))
end

function setflow!(model::Vector{QLocation}, flow::AbstractArray, row::Int32, col::Int64)
    model[row].flow = JuliaItemModel([QFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow])
end

"""
    QFlow

A flow in a location.

    QFlow(variable::String, expression::String)

Create a new flow with the given variable and expression.
"""
mutable struct QFlow
    variable::String
    expression::String
end

function QFlow()::QFlow
    return QFlow("", "")
end


"""
    QEdge

An edge in a hybrid game.
"""
mutable struct QEdge
    source::String
    target::String
    guard::String
    agent::String
    action::String
    jump::JuliaItemModel
end

function QEdge()::QEdge
    return QEdge("", "", "", "", "", JuliaItemModel(QJump[]))
end

"""
    QEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)

Create a new edge with the given source, target, guard, agent, action, and jump.
"""
function QEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)::QEdge
    return QEdge(source, target, guard, agent, action, JuliaItemModel([QJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump]))
end

function setjump!(model::Vector{QEdge}, jump::AbstractArray, row::Int32, col::Int64)
    model[row].jump = JuliaItemModel([QJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump])
end

"""
    QJump

A jump in an edge.

    QJump(variable::String, expression::String)

Create a new jump with the given variable and expression.
"""
mutable struct QJump
    variable::String
    expression::String
end

function QJump()::QJump
    return QJump("", "")
end

"""
    QQuery

A query in a hybrid game.

    QQuery(formula::String)

Create a new query with the given formula.
"""
mutable struct QQuery
    formula::String
    verified::Bool
    QQuery(formula::String) = new(formula, false)
end

function QQuery()::QQuery
    return QQuery("")
end

StructTypes.StructType(::Type{QAction}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QAgent}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QVariable}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QTrigger}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QLocation}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QFlow}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QEdge}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QJump}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QQuery}) = StructTypes.Mutable()


"""
    QBranch

A tree branch used in QML models.
"""
mutable struct QBranch
    agent::String
    trigger::String
    time::Float64
    active_nodes::JuliaItemModel
    passive_nodes::JuliaItemModel
end

"""
    QBranch(branch::GUIBranch)::QBranch

Create a QBranch from the given branch `branch`.
# Arguments
- `branch::GUIBranch`: the branch
"""
function QBranch(branch::GUIBranch)::QBranch
    return QBranch(
        if isnothing(branch.reaching_decision)
            ""
        else
            string(branch.reaching_decision[1])
        end,
        if isnothing(branch.reaching_trigger)
            ""
        else
            str(branch.reaching_trigger)
        end,
        trunc(branch.config.global_clock, digits=5),
        JuliaItemModel([QActiveNode(node) for node in branch.active_nodes]),
        JuliaItemModel([QPassiveNode(node) for node in branch.passive_nodes])
    )
end

"""
    QActiveNode

An active tree node used in QML models.
"""
mutable struct QActiveNode
    location::String
    action::String
    valuation::String
    clickable::Bool
end

"""
    QActiveNode(node::GUINode)::QActiveNode

Create a QAction from the given GUI node `node`.
# Arguments
- `node::GUINode`: the gui node
"""
function QActiveNode(node::GUINode)::QActiveNode
    QActiveNode(
        string(node.config.location.name),
        if isnothing(node.reaching_decision)
            ""
        else
            string(node.reaching_decision[2])
        end,
        _get_valuation_string(node.config.valuation),
        !isempty(node.branches)
    )
end

"""
    QPassiveNode

A passive tree node used in QML models.
"""
mutable struct QPassiveNode
    valuation::String
    time::Float64
end

"""
    QPassiveNode(node::PassiveNode)::QPassiveNode

Create a QPassiveNode from the given passive node `node`.
# Arguments
- `node::PassiveNode`: the passive node
"""
function QPassiveNode(node::PassiveNode)::QPassiveNode
    return QPassiveNode(
        _get_valuation_string(node.config.valuation),
        trunc(node.config.global_clock, digits=5)
    )
end

function _get_valuation_string(valuation::Valuation)::String
    str = ""
    for (i, val) in enumerate(keys(valuation))
        str *= "$(string(val)) = $(trunc(valuation[val], digits=5))"
        if i != length(keys(valuation))
            str *= ",\n"
        end
    end
    return "{$str}"
end
