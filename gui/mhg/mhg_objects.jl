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

# Functions:
- `mhg_name_available(name::QString)::Bool`: Check whether a name is available.
- `mhg_is_formula(text::QString, level::QString)::Bool`: Check whether a formula is valid at a given parse level.
- `mhg_save(path::QString)`: Save the current game to a file.
- `mhg_load(path::QString)::String`: Load a game from a file.
- `mhg_verify()::String`: Verify the current game.

# Authors:
- Moritz Maas
"""

using JSON3, StructTypes

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

mhg_action_list::Vector{QMHGAction} = [QMHGAction("action")]
mhg_models["actions"] = JuliaItemModel(mhg_action_list)

mhg_agent_list::Vector{QMHGAgent} = [QMHGAgent("agent")]
mhg_models["agents"] = JuliaItemModel(mhg_agent_list)

mhg_variable_list::Vector{QMHGVariable} = [QMHGVariable("variable", true, false, 0.0, 10.0)]
mhg_models["variables"] = JuliaItemModel(mhg_variable_list)
roles["name"] = roleindex(mhg_models["variables"], "name")

mhg_location_list::Vector{QMHGLocation} = [QMHGLocation("location", true, "true", JuliaItemModel([QMHGFlow("variable", false, false, 0.0, 1.0)]))]
mhg_models["locations"] = JuliaItemModel(mhg_location_list)
setsetter!(mhg_models["locations"], setflow!, roleindex(mhg_models["locations"], "flow"))

mhg_edge_list::Vector{QMHGEdge} = [QMHGEdge("location", "location", "true", "agent", "action", JuliaItemModel([QMHGJump("variable", false, false, false, 0.0, 1.0)]))]
mhg_models["edges"] = JuliaItemModel(mhg_edge_list)
setsetter!(mhg_models["edges"], setjump!, roleindex(mhg_models["edges"], "jump"))

mhg_query_list::Vector{QMHGQuery} = [QMHGQuery("<<agent>> F true")]
mhg_models["queries"] = JuliaItemModel(mhg_query_list)

"""
    mhg_name_available(name::QString)::Bool

Check whether a name is available (not used by any action, agent, variable or location).

# Arguments
- `name::QString`: the name to check
"""
function mhg_name_available(name::QString)::Bool
    return !any(v -> v.name == name, [mhg_action_list; mhg_agent_list; mhg_variable_list; mhg_location_list])
end

"""
    mhg_is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: the formula as a string
- `level::QString`: the parse level as a string (`expression`, `constraint`, `state` or `strategy`)
"""
function mhg_is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in mhg_agent_list],
        [x.name for x in mhg_location_list],
        [x.name for x in mhg_variable_list]
    )
    try
        # TODO: Add rectangular constraint
        parse(String(text), bindings, eval(Symbol(String(level))))
        return true
    catch
        return false
    end
end

"""
    mhg_save(path::QString)

Save the current game to a file given by `path`.

# Arguments
- `path::QString`: the file path to save to
"""
function mhg_save(path::QString)
    data::Dict{String, Any} = Dict([
        "game_type" => "MHG",
        "agents" => mhg_agent_list,
        "actions" => mhg_action_list,
        "variables" => mhg_variable_list,
        "locations" => [
            Dict(
                "name" => loc.name,
                "initial" => loc.initial,
                "invariant" => loc.invariant,
                "flow" => [
                    Dict(
                        "variable" => loc.flow[i].variable,
                        "lower_open" => loc.flow[i].lower_open,
                        "upper_open" => loc.flow[i].upper_open,
                        "lower" => loc.flow[i].lower,
                        "upper" => loc.flow[i].upper,
                    ) for i in 1:length(loc.flow)
                ],
            ) for loc in mhg_location_list
        ],
        "edges" => [
            Dict(
                "source" => edge.source,
                "target" => edge.target,
                "guard" => edge.guard,
                "agent" => edge.agent,
                "action" => edge.action,
                "jump" => [
                    Dict(
                        "variable" => edge.jump[i].variable,
                        "is_none" => edge.jump[i].is_none,
                        "lower_open" => edge.jump[i].lower_open,
                        "upper_open" => edge.jump[i].upper_open,
                        "lower" => edge.jump[i].lower,
                        "upper" => edge.jump[i].upper,
                    ) for i in 1:length(edge.jump)
                ],
            ) for edge in mhg_edge_list
        ],
        "queries" => mhg_query_list,
        "config" => Dict([
            "max_steps" => mhg_models["max_steps"],
            "time_bound" => mhg_models["time_bound"],
            "state_formula" => mhg_models["state_formula"],
        ]),
    ])

    open(replace(String(path), r"^(file:\/{2})" => ""), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

"""
    mhg_load(path::QString)::String

Load a game from a file given by `path`.

# Arguments
- `path::QString`: the file path to load from
"""
function mhg_load(path::QString)::String
    function load_elements(name::String, type::Type, list::Vector)
        empty!(list)
        for element in data[name]
            push!(list, StructTypes.constructfrom(type, element))
        end
    end

    data = Dict{String, Any}()

    try
        data = open(replace(String(path), r"^(file:\/{2})" => ""), "r") do f
            JSON3.read(f)
        end
    catch e
        return String(strip(e.msg, ['\n', '\r', ' ']))
    end

    try
        if data["game_type"] != "MHG"
            return "not a Monotonic Hybrid Game"
        end
        load_elements("agents", QMHGAgent, mhg_agent_list)
        load_elements("actions", QMHGAction, mhg_action_list)
        load_elements("variables", QMHGVariable, mhg_variable_list)
        empty!(mhg_location_list)
        for loc in data["locations"]
            flow_list::Vector{QMHGFlow} = Vector{QMHGFlow}()
            for flow in loc["flow"]
                push!(flow_list, StructTypes.constructfrom(QMHGFlow, flow))
            end
            push!(mhg_location_list, QMHGLocation(loc["name"], loc["initial"], loc["invariant"], JuliaItemModel(flow_list)))
        end
        empty!(mhg_edge_list)
        for edge in data["edges"]
            jump_list::Vector{QMHGJump} = Vector{QMHGJump}()
            for jump in edge["jump"]
                push!(jump_list, StructTypes.constructfrom(QMHGJump, jump))
            end
            push!(mhg_edge_list, QMHGEdge(edge["source"], edge["target"], edge["guard"], edge["agent"], edge["action"], JuliaItemModel(jump_list)))
        end
        load_elements("queries", QMHGQuery, mhg_query_list)

        mhg_models["max_steps"] = data["config"]["max_steps"]
        mhg_models["time_bound"] = data["config"]["time_bound"]
        mhg_models["state_formula"] = data["config"]["state_formula"]
    catch e
        return "invalid HYTRIG file for Monotonic Hybrid Games: Missing key $(e.key)"
    end

    return ""
end

"""
    mhg_verify()::String

Verify the current game.
"""
function mhg_verify()::String
    # TODO: Implement verification for MHGs
    return "verification not yet implemented for Monotonic Hybrid Games"
end
