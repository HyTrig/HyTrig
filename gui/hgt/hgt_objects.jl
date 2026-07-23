"""
    HGT Objects

This file defines the QML objects used in the HyTrig GUI by the HGT game type.

# Types:
- `QHGTAction`: Represents an action in a hybrid game.
- `QHGTAgent`: Represents an agent in a hybrid game.
- `QHGTVariable`: Represents a variable in a hybrid game.
- `QHGTTrigger`: Represents a trigger in a hybrid game.
- `QHGTLocation`: Represents a location in a hybrid game.
- `QHGTFlow`: Represents a flow in a location.
- `QHGTEdge`: Represents an edge in a hybrid game.
- `QHGTJump`: Represents a jump in an edge.
- `QHGTQuery`: Represents a query in a hybrid game.
- `QHGTBranch`: Represents a tree branch used in QML models.
- `QHGTDecisionNode`: Represents an active tree node used in QML models.
- `QHGTPropertyNode`: Represents a passive tree node used in QML models.

# Global variables:
- `hgt_action_list::Vector{QHGTAction}`: A list of actions
- `hgt_agent_list::Vector{QHGTAgent}`: A list of agents
- `hgt_variable_list::Vector{QHGTVariable}`: A list of variables
- `hgt_trigger_list::Vector{QHGTTrigger}`: A list of triggers
- `hgt_location_list::Vector{QHGTLocation}`: A list of locations
- `hgt_edge_list::Vector{QHGTEdge}`: A list of edges
- `hgt_query_list::Vector{QHGTQuery}`: A list of queries
- `hgt_branch_list::Vector{QHGTBranch}`: A list of tree

# Authors:
"""

"""
    QHGTAction

An action in a hybrid game.

    QHGTAction(name::String)
Create a new action with the given name.
"""
mutable struct QHGTAction
    name::String
end

function QHGTAction()::QHGTAction
    return QHGTAction("")
end

"""
    QHGTAgent
An agent in a hybrid game.

    QHGTAgent(name::String)

Create a new agent with the given name.
"""
mutable struct QHGTAgent
    name::String
end

function QHGTAgent()::QHGTAgent
    return QHGTAgent("")
end

"""
    QHGTVariable

A variable in a hybrid game.

    QHGTVariable(name::String, expression::String)

Create a new variable with the given name and expression.
"""
mutable struct QHGTVariable
    name::String
    expression::String
end

function QHGTVariable()::QHGTVariable
    return QHGTVariable("", "")
end

"""
    QHGTTrigger

A trigger in a hybrid game.

    QHGTTrigger(agent::String, trigger::String)

Create a new trigger with the given agent and trigger.
"""
mutable struct QHGTTrigger
    agent::String
    trigger::String
end

function QHGTTrigger()::QHGTTrigger
    return QHGTTrigger("", "")
end

"""
    QHGTLocation

A location in a hybrid game.
"""
mutable struct QHGTLocation
    name::String
    initial::Bool
    invariant::String
    flow::JuliaItemModel
end

function QHGTLocation()::QHGTLocation
    return QHGTLocation("", true, "", JuliaItemModel(QHGTFlow[]))
end

"""
    QHGTLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)

Create a new location with the given name, invariant, initial flag, and flow.
"""
function QHGTLocation(name::String, invariant::String, initial::Bool, flow::AbstractArray)::QHGTLocation
    return QHGTLocation(name, invariant, initial, JuliaItemModel([QHGTFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow]))
end

function setflow!(model::Vector{QHGTLocation}, flow::AbstractArray, row::Int32, col::Int64)
    model[row].flow = JuliaItemModel([QHGTFlow(QML.value(f)["variable"], QML.value(f)["expression"]) for f in flow])
end

"""
    QHGTFlow

A flow in a location.

    QHGTFlow(variable::String, expression::String)

Create a new flow with the given variable and expression.
"""
mutable struct QHGTFlow
    variable::String
    expression::String
end

function QHGTFlow()::QHGTFlow
    return QHGTFlow("", "")
end


"""
    QHGTEdge

An edge in a hybrid game.
"""
mutable struct QHGTEdge
    source::String
    target::String
    guard::String
    agent::String
    action::String
    jump::JuliaItemModel
end

function QHGTEdge()::QHGTEdge
    return QHGTEdge("", "", "", "", "", JuliaItemModel(QHGTJump[]))
end

"""
    QHGTEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)

Create a new edge with the given source, target, guard, agent, action, and jump.
"""
function QHGTEdge(source::String, target::String, guard::String, agent::String, action::String, jump::AbstractArray)::QHGTEdge
    return QHGTEdge(source, target, guard, agent, action, JuliaItemModel([QHGTJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump]))
end

function setjump!(model::Vector{QHGTEdge}, jump::AbstractArray, row::Int32, col::Int64)
    model[row].jump = JuliaItemModel([QHGTJump(QML.value(j)["variable"], QML.value(j)["expression"]) for j in jump])
end

"""
    QHGTJump

A jump in an edge.

    QHGTJump(variable::String, expression::String)

Create a new jump with the given variable and expression.
"""
mutable struct QHGTJump
    variable::String
    expression::String
end

function QHGTJump()::QHGTJump
    return QHGTJump("", "")
end

"""
    QHGTQuery

A query in a hybrid game.

    QHGTQuery(formula::String)

Create a new query with the given formula.
"""
mutable struct QHGTQuery
    formula::String
    verified::Bool
    QHGTQuery(formula::String) = new(formula, false)
end

function QHGTQuery()::QHGTQuery
    return QHGTQuery("")
end

"""
    QHGTBranch

A tree branch used in QML models.
"""
mutable struct QHGTBranch
    agent::String
    trigger::String
    valuation::String
    time::Float64
    action_nodes::JuliaItemModel
    property_nodes::JuliaItemModel
end

"""
    QHGTBranch(branch::GUIBranch)::QHGTBranch

Create a QHGTBranch from the given branch `branch`.
# Arguments
- `branch::GUIBranch`: The branch.
"""
function QHGTBranch(branch::GUIBranch)::QHGTBranch
    return QHGTBranch(
        if isnothing(branch.reaching_trigger)
            ""
        else
            string(branch.reaching_trigger[1])
        end,
        if isnothing(branch.reaching_trigger)
            ""
        else
            constraint_to_string(branch.reaching_trigger[2])
        end,
        _get_valuation_string(branch.config.valuation),
        trunc(branch.config.global_clock, digits=4),
        JuliaItemModel([QHGTDecisionNode(node) for node in branch.action_nodes]),
        JuliaItemModel([QHGTPropertyNode(node) for node in branch.property_nodes])
    )
end

"""
    QHGTDecisionNode

An active tree node used in QML models.
"""
mutable struct QHGTDecisionNode
    location::String
    action::String
    valuation::String
    terminal::Bool
end

"""
    QHGTDecisionNode(node::GUINode)::QHGTDecisionNode

Create a decision node from the given GUI node `node`.
# Arguments
- `node::GUINode`: The GUI node.
"""
function QHGTDecisionNode(node::GUINode)::QHGTDecisionNode
    QHGTDecisionNode(
        string(node.config.location.name),
        if isnothing(node.reaching_decision)
            ""
        else
            string(node.reaching_decision[2])
        end,
        _get_valuation_string(node.config.valuation),
        isempty(node.branches)
    )
end

"""
    QHGTPropertyNode

A passive tree node used in QML models.
"""
mutable struct QHGTPropertyNode
    valuation::String
    time::Float64
    is_end::Bool
    deadlock::Bool
end

"""
    QHGTPropertyNode(node::PropertyNode)::QHGTPropertyNode

Create a QHGTPropertyNode from the given property node `node`.
# Arguments
- `node::PropertyNode`: The property node.
"""
function QHGTPropertyNode(node::PropertyNode)::QHGTPropertyNode
    return QHGTPropertyNode(
        _get_valuation_string(node.config.valuation),
        trunc(node.config.global_clock, digits=4),
        false,
        false
    )
end

"""
    QHGTPropertyNode(node::FinalNode)::QHGTPropertyNode

Create a QHGTPropertyNode from the given final node `node`.
# Arguments
- `node::FinalNode`: The final node.
"""
function QHGTPropertyNode(node::FinalNode)::QHGTPropertyNode
    return QHGTPropertyNode(
        _get_valuation_string(node.config.valuation),
        trunc(node.config.global_clock, digits=4),
        true,
        node.deadlock
    )
end

# Define StructTypes for JSON3 serialization
StructTypes.StructType(::Type{QHGTAction}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTAgent}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTVariable}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTTrigger}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTLocation}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTFlow}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTEdge}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTJump}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTQuery}) = StructTypes.Mutable()

hgt_models["max_steps"] = "10"
hgt_models["time_bound"] = "13.37"
hgt_models["state_formula"] = "!location"
hgt_models["tree_location"] = ""

"""
    hgt_action_list::Vector{QHGTAction}

A list of actions in the current Hybrid Game with Triggers.
"""
hgt_action_list::Vector{QHGTAction} = [QHGTAction("action")]
hgt_models["actions"] = JuliaItemModel(hgt_action_list)

"""
    hgt_agent_list::Vector{QHGTAgent}

A list of agents in the current Hybrid Game with Triggers.
"""
hgt_agent_list::Vector{QHGTAgent} = [QHGTAgent("agent")]
hgt_models["agents"] = JuliaItemModel(hgt_agent_list)

"""
    hgt_variable_list::Vector{QHGTVariable}

A list of variables in the current Hybrid Game with Triggers.
"""
hgt_variable_list::Vector{QHGTVariable} = [QHGTVariable("variable", "0")]
hgt_models["variables"] = JuliaItemModel(hgt_variable_list)
roles["name"] = roleindex(hgt_models["variables"], "name")

"""
    hgt_trigger_list::Vector{QHGTTrigger}

A list of triggers in the current Hybrid Game with Triggers.
"""
hgt_trigger_list::Vector{QHGTTrigger} = [QHGTTrigger("agent", "true")]
hgt_models["triggers"] = JuliaItemModel(hgt_trigger_list)

"""
    hgt_location_list::Vector{QHGTLocation}

A list of locations in the current Hybrid Game with Triggers.
"""
hgt_location_list::Vector{QHGTLocation} = [QHGTLocation("location", true, "true", JuliaItemModel([QHGTFlow("variable", "variable + 1")]))]
hgt_models["locations"] = JuliaItemModel(hgt_location_list)
setsetter!(hgt_models["locations"], setflow!, roleindex(hgt_models["locations"], "flow"))

"""
    hgt_edge_list::Vector{QHGTEdge}

A list of edges in the current Hybrid Game with Triggers.
"""
hgt_edge_list::Vector{QHGTEdge} = [QHGTEdge("location", "location", "true", "agent", "action", JuliaItemModel([QHGTJump("variable", "variable + 1")]))]
hgt_models["edges"] = JuliaItemModel(hgt_edge_list)
setsetter!(hgt_models["edges"], setjump!, roleindex(hgt_models["edges"], "jump"))

"""
    hgt_query_list::Vector{QHGTQuery}

A list of queries in the current Hybrid Game with Triggers.
"""
hgt_query_list::Vector{QHGTQuery} = [QHGTQuery("<<agent>> F true")]
hgt_models["queries"] = JuliaItemModel(hgt_query_list)

"""
    hgt_branch_list::Vector{QHGTBranch}

A list of branches in the current Hybrid Game with Triggers.
"""
hgt_branch_list::Vector{QHGTBranch} = QHGTBranch[]
hgt_models["branches"] = JuliaItemModel(hgt_branch_list)
