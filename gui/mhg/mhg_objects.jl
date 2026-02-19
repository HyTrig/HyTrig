"""
    MHG Objects

This file defines the QML objects used in the HyTrig GUI by the MHG game type.

# Types:
- `QMHGAction`: Represents an action in a hybrid game.
- `QMHGAgent`: Represents an agent in a hybrid game.
- `QMHGVariable`: Represents a variable in a hybrid game.
- `QMHGLocation`: Represents a location in a hybrid game.
- `QMHGFlow`: Represents a flow in a location.
- `QMHGEdge`: Represents an edge in a hybrid game.
- `QMHGJump`: Represents a jump in an edge.
- `QMHGQuery`: Represents a query in a hybrid game.

# Global variables:
- `mhg_action_list::Vector{QMHGAction}`: A list of actions
- `mhg_agent_list::Vector{QMHGAgent}`: A list of agents
- `mhg_variable_list::Vector{QMHGVariable}`: A list of variables
- `mhg_location_list::Vector{QMHGLocation}`: A list of locations
- `mhg_edge_list::Vector{QMHGEdge}`: A list of edges
- `mhg_query_list::Vector{QMHGQuery}`: A list of queries

# Authors:
- Moritz Maas
"""

"""
    QMHGAction

An action in a hybrid game.

    QMHGAction(name::String)
Create a new action with the given name.
"""
mutable struct QMHGAction
    name::String
end

function QMHGAction()::QMHGAction
    return QMHGAction("")
end

"""
    QMHGAgent
An agent in a hybrid game.

    QMHGAgent(name::String)

Create a new agent with the given name.
"""
mutable struct QMHGAgent
    name::String
end

function QMHGAgent()::QMHGAgent
    return QMHGAgent("")
end

"""
    QMHGVariable

A variable in a hybrid game.

    QMHGVariable(name::String, lower_open::Bool, upper_open::Bool, lower::Float64, upper::Float64)

Create a new variable with the given name and interval.
"""
mutable struct QMHGVariable
    name::String
    lower_open::Bool
    upper_open::Bool
    lower::Float64
    upper::Float64
end

function QMHGVariable()::QMHGVariable
    return QMHGVariable("", true, true, 0.0, 0.0)
end

"""
    QMHGLocation

A location in a hybrid game.
"""
mutable struct QMHGLocation
    name::String
    initial::Bool
    invariant::String
    flow::JuliaItemModel
end

function QMHGLocation()::QMHGLocation
    return QMHGLocation("", true, "", JuliaItemModel(QMHGFlow[]))
end

"""
    QMHGLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)

Create a new location with the given name, invariant, initial flag, and flow.
"""
function QMHGLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)::QMHGLocation
    return QMHGLocation(name, invariant, initial,JuliaItemModel(
        [
            QMHGFlow(
                QML.value(f)["variable"],
                QML.value(f)["lower_open"],
                QML.value(f)["upper_open"],
                QML.value(f)["lower"],
                QML.value(f)["upper"]
            ) for f in flow
        ])
    )
end

function setflow!(model::Vector{QMHGLocation}, flow::AbstractArray, row::Int32, col::Int64)
    model[row].flow = JuliaItemModel(
        [
            QMHGFlow(
                QML.value(f)["variable"],
                QML.value(f)["lower_open"],
                QML.value(f)["upper_open"],
                QML.value(f)["lower"],
                QML.value(f)["upper"]
            ) for f in flow
        ]
    )
end

"""
    QMHGFlow

A flow in a location.

    QMHGFlow(variable::String, lower_open::Bool, upper_open::Bool, lower::Float64, upper::Float64)

Create a new flow with the given variable and interval.
"""
mutable struct QMHGFlow
    variable::String
    lower_open::Bool
    upper_open::Bool
    lower::Float64
    upper::Float64
end

function QMHGFlow()::QMHGFlow
    return QMHGFlow("", true, true, 0.0, 0.0)
end


"""
    QMHGEdge

An edge in a hybrid game.
"""
mutable struct QMHGEdge
    source::String
    target::String
    guard::String
    agent::String
    action::String
    jump::JuliaItemModel
end

function QMHGEdge()::QMHGEdge
    return QMHGEdge("", "", "", "", "", JuliaItemModel(QMHGJump[]))
end

"""
    QMHGEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)

Create a new edge with the given source, target, guard, agent, action, and jump.
"""
function QMHGEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)::QMHGEdge
    return QMHGEdge(source, target, guard, agent, action, JuliaItemModel(
        [
            QMHGJump(
                QML.value(j)["variable"],
                QML.value(j)["is_none"],
                QML.value(j)["lower_open"],
                QML.value(j)["upper_open"],
                QML.value(j)["lower"],
                QML.value(j)["upper"]
            ) for j in jump
        ])
    )
end

function setjump!(model::Vector{QMHGEdge}, jump::AbstractArray, row::Int32, col::Int64)
    model[row].jump = JuliaItemModel(
        [
            QMHGJump(
                QML.value(j)["variable"],
                QML.value(j)["is_none"],
                QML.value(j)["lower_open"],
                QML.value(j)["upper_open"],
                QML.value(j)["lower"],
                QML.value(j)["upper"]
            ) for j in jump
        ]
    )
end

"""
    QMHGJump

A jump in an edge.

    QMHGJump(variable::String, is_none::Bool, lower_open::Bool, upper_open::Bool, lower::Float64, upper::Float64)

Create a new jump with the given variable and interval.
"""
mutable struct QMHGJump
    variable::String
    is_none::Bool
    lower_open::Bool
    upper_open::Bool
    lower::Float64
    upper::Float64
end

function QMHGJump()::QMHGJump
    return QMHGJump("", true, true, true, 0.0, 0.0)
end

"""
    QMHGQuery

A query in a hybrid game.

    QMHGQuery(formula::String)

Create a new query with the given formula.
"""
mutable struct QMHGQuery
    formula::String
    verified::Bool
    QMHGQuery(formula::String) = new(formula, false)
end

function QMHGQuery()::QMHGQuery
    return QMHGQuery("")
end

# Define StructTypes for JSON3 serialization
StructTypes.StructType(::Type{QMHGAction}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGAgent}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGVariable}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGLocation}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGFlow}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGEdge}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGJump}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QMHGQuery}) = StructTypes.Mutable()

mhg_models["max_steps"] = "10"
mhg_models["time_bound"] = "13.37"
mhg_models["state_formula"] = "!location"

"""
    mhg_action_list::Vector{QMHGAction}

A list of actions in the current Monotonic Hybrid Game.
"""
mhg_action_list::Vector{QMHGAction} = [QMHGAction("action")]
mhg_models["actions"] = JuliaItemModel(mhg_action_list)

"""
    mhg_agent_list::Vector{QMHGAgent}

A list of agents in the current Monotonic Hybrid Game.
"""
mhg_agent_list::Vector{QMHGAgent} = [QMHGAgent("agent")]
mhg_models["agents"] = JuliaItemModel(mhg_agent_list)

"""
    mhg_variable_list::Vector{QMHGVariable}

A list of variables in the current Monotonic Hybrid Game.
"""
mhg_variable_list::Vector{QMHGVariable} = [QMHGVariable("variable", true, false, 0.0, 10.0)]
mhg_models["variables"] = JuliaItemModel(mhg_variable_list)
roles["name"] = roleindex(mhg_models["variables"], "name")

"""
    mhg_location_list::Vector{QMHGLocation}

A list of locations in the current Monotonic Hybrid Game.
"""
mhg_location_list::Vector{QMHGLocation} = [QMHGLocation("location", true, "true", JuliaItemModel([QMHGFlow("variable", false, false, 0.0, 1.0)]))]
mhg_models["locations"] = JuliaItemModel(mhg_location_list)
setsetter!(mhg_models["locations"], setflow!, roleindex(mhg_models["locations"], "flow"))

"""
    mhg_edge_list::Vector{QMHGEdge} 

A list of edges in the current Monotonic Hybrid Game.
"""
mhg_edge_list::Vector{QMHGEdge} = [QMHGEdge("location", "location", "true", "agent", "action", JuliaItemModel([QMHGJump("variable", false, false, false, 0.0, 1.0)]))]
mhg_models["edges"] = JuliaItemModel(mhg_edge_list)
setsetter!(mhg_models["edges"], setjump!, roleindex(mhg_models["edges"], "jump"))

"""
    mhg_query_list::Vector{QMHGQuery}

A list of queries in the current Monotonic Hybrid Game.
"""
mhg_query_list::Vector{QMHGQuery} = [QMHGQuery("<<agent>> F true")]
mhg_models["queries"] = JuliaItemModel(mhg_query_list)
