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

# Functions:
- `hgt_name_available(name::QString)::Bool`: Check whether a name is available.
- `hgt_is_formula(text::QString, level::QString)::Bool`: Check whether a formula is valid at a given parse level.
- `hgt_save(path::QString)`: Save the current game to a file.
- `hgt_load(path::QString)::String`: Load a game from a file.
- `hgt_verify()::String`: Verify the current game.

# Authors:
- Moritz Maas
"""

using JSON3, StructTypes

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

StructTypes.StructType(::Type{QHGTAction}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTAgent}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTVariable}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTTrigger}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTLocation}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTFlow}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTEdge}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTJump}) = StructTypes.Mutable()
StructTypes.StructType(::Type{QHGTQuery}) = StructTypes.Mutable()

hgt_models = JuliaPropertyMap()

hgt_models["max_steps"] = "10"
hgt_models["time_bound"] = "13.37"
hgt_models["state_formula"] = "!location"

hgt_action_list::Vector{QHGTAction} = [QHGTAction("action")]
hgt_models["actions"] = JuliaItemModel(hgt_action_list)

hgt_agent_list::Vector{QHGTAgent} = [QHGTAgent("agent")]
hgt_models["agents"] = JuliaItemModel(hgt_agent_list)

hgt_variable_list::Vector{QHGTVariable} = [QHGTVariable("variable", "0")]
hgt_models["variables"] = JuliaItemModel(hgt_variable_list)
roles["name"] = roleindex(hgt_models["variables"], "name")

hgt_trigger_list::Vector{QHGTTrigger} = [QHGTTrigger("agent", "true")]
hgt_models["triggers"] = JuliaItemModel(hgt_trigger_list)

hgt_location_list::Vector{QHGTLocation} = [QHGTLocation("location", true, "true", JuliaItemModel([QHGTFlow("variable", "variable + 1")]))]
hgt_models["locations"] = JuliaItemModel(hgt_location_list)
setsetter!(hgt_models["locations"], setflow!, roleindex(hgt_models["locations"], "flow"))

hgt_edge_list::Vector{QHGTEdge} = [QHGTEdge("location", "location", "true", "agent", "action", JuliaItemModel([QHGTJump("variable", "variable + 1")]))]
hgt_models["edges"] = JuliaItemModel(hgt_edge_list)
setsetter!(hgt_models["edges"], setjump!, roleindex(hgt_models["edges"], "jump"))

hgt_query_list::Vector{QHGTQuery} = [QHGTQuery("<<agent>> F true")]
hgt_models["queries"] = JuliaItemModel(hgt_query_list)

"""
    hgt_name_available(name::QString)::Bool

Check whether a name is available (not used by any action, agent, variable or location).

# Arguments
- `name::QString`: the name to check
"""
function hgt_name_available(name::QString)::Bool
    return !any(v -> v.name == name, [hgt_action_list; hgt_agent_list; hgt_variable_list; hgt_location_list])
end

"""
    hgt_is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: the formula as a string
- `level::QString`: the parse level as a string (`expression`, `constraint`, `state` or `strategy`)
"""
function hgt_is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in hgt_agent_list],
        [x.name for x in hgt_location_list],
        [x.name for x in hgt_variable_list]
    )
    try
        parse(String(text), bindings, eval(Symbol(String(level))))
        return true
    catch
        return false
    end
end

"""
    hgt_save(path::QString)

Save the current game to a file given by `path`.

# Arguments
- `path::QString`: the file path to save to
"""
function hgt_save(path::QString)
    data::Dict{String, Any} = Dict([
        "game_type" => "HGT",
        "agents" => hgt_agent_list,
        "actions" => hgt_action_list,
        "variables" => hgt_variable_list,
        "triggers" => hgt_trigger_list,
        "locations" => [
            Dict(
                "name" => loc.name,
                "initial" => loc.initial,
                "invariant" => loc.invariant,
                "flow" => [
                    Dict(
                        "variable" => loc.flow[i].variable,
                        "expression" => loc.flow[i].expression,
                    ) for i in 1:length(loc.flow)
                ],
            ) for loc in hgt_location_list
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
                        "expression" => edge.jump[i].expression,
                    ) for i in 1:length(edge.jump)
                ],
            ) for edge in hgt_edge_list
        ],
        "queries" => hgt_query_list,
        "config" => Dict([
            "max_steps" => hgt_models["max_steps"],
            "time_bound" => hgt_models["time_bound"],
            "state_formula" => hgt_models["state_formula"],
        ]),
    ])

    open(replace(String(path), r"^(file:\/{2})" => ""), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

"""
    hgt_load(path::QString)::String

Load a game from a file given by `path`.

# Arguments
- `path::QString`: the file path to load from
"""
function hgt_load(path::QString)::String
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
        if data["game_type"] != "HGT"
            return "not a Hybrid Game with Triggers"
        end
        load_elements("agents", QHGTAgent, hgt_agent_list)
        load_elements("actions", QHGTAction, hgt_action_list)
        load_elements("variables", QHGTVariable, hgt_variable_list)
        load_elements("triggers", QHGTTrigger, hgt_trigger_list)
        empty!(hgt_location_list)
        for loc in data["locations"]
            flow_list::Vector{QHGTFlow} = Vector{QHGTFlow}()
            for flow in loc["flow"]
                push!(flow_list, StructTypes.constructfrom(QHGTFlow, flow))
            end
            push!(hgt_location_list, QHGTLocation(loc["name"], loc["initial"], loc["invariant"], JuliaItemModel(flow_list)))
        end
        empty!(hgt_edge_list)
        for edge in data["edges"]
            jump_list::Vector{QHGTJump} = Vector{QHGTJump}()
            for jump in edge["jump"]
                push!(jump_list, StructTypes.constructfrom(QHGTJump, jump))
            end
            push!(hgt_edge_list, QHGTEdge(edge["source"], edge["target"], edge["guard"], edge["agent"], edge["action"], JuliaItemModel(jump_list)))
        end
        load_elements("queries", QHGTQuery, hgt_query_list)

        hgt_models["max_steps"] = data["config"]["max_steps"]
        hgt_models["time_bound"] = data["config"]["time_bound"]
        hgt_models["state_formula"] = data["config"]["state_formula"]
    catch e
        return "invalid HYTRIG file for Hybrid Games with Triggers: Missing key $(e.key)"
    end

    return ""
end

"""
    hgt_verify()::String

Verify the current game.
"""
function hgt_verify()::String
    global game_tree
    bindings::Bindings = Bindings(
        [x.name for x in hgt_agent_list],
        [x.name for x in hgt_location_list],
        [x.name for x in hgt_variable_list]
    )
    results::Vector{Bool} = []
    try
        locations = Vector{Location}([
            Location(
                Symbol(x.name),
                parse(x.invariant, bindings, constraint),
                ReAssignment(
                    Variable(x.flow[i].variable) => parse(x.flow[i].expression, bindings, expression) for i in 1:length(x.flow)
                )
            ) for x in hgt_location_list
        ])
        initial_valuation = Valuation(
            Variable(x.name) => Base.parse(Float64, x.expression) for x in hgt_variable_list
        )
        edges = Vector{Edge}([
            Edge(
                Symbol(i),
                locations[findfirst(loc -> loc.name == Symbol(edge.source), locations)],
                locations[findfirst(loc -> loc.name == Symbol(edge.target), locations)],
                parse(edge.guard, bindings, constraint),
                Decision(
                    Agent(edge.agent),
                    Action(edge.action)
                ),
                ReAssignment(
                    Variable(edge.jump[j].variable) => parse(edge.jump[j].expression, bindings, expression) for j in 1:length(edge.jump)
                )
            ) for (i, edge) in enumerate(hgt_edge_list)
        ])  
        triggers = Dict{Agent, Vector{Constraint}}()
        for x in hgt_trigger_list
            agent = Agent(x.agent)
            if !haskey(triggers, agent)
                triggers[agent] = Vector{Constraint}()
            end
            push!(triggers[agent], parse(x.trigger, bindings, constraint))
        end    
        game = Game(
            locations,
            locations[findfirst(loc -> loc.initial, hgt_location_list)],
            initial_valuation,
            [Agent(x.name) for x in hgt_agent_list],
            [Action(x.name) for x in hgt_action_list],
            edges,
            triggers,
            true
        )

        results, game_tree = evaluate_queries(
            game,
            Termination_Conditions(
                Base.parse(Float64, hgt_models["time_bound"]),
                Base.parse(Int64, hgt_models["max_steps"]),
                parse(hgt_models["state_formula"], bindings, state)
            ),
            Vector{Strategy_Formula}([parse(query.formula, bindings, strategy) for query in hgt_query_list])
        )
    catch e
        if e isa ParseError
            return "parse error: $(e.msg)"
        end
        throw(e)
    end

    empty!(branch_list)

    if !isnothing(game_tree)
        game_tree = build_gui_tree(game_tree)
        push!(branch_list, QBranch(game_tree.branches[1]))
    end

    for (i, query) in enumerate(hgt_query_list)
        query.verified = results[i]
    end

    return ""
end
