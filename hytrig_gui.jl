"""
    HyTrig-GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

using Pkg

Pkg.activate(".")
Pkg.instantiate()

using JSON3, QML, StructTypes

include("gui/qml_objects.jl")
include("src/parsers/syntax_parsers/parser.jl")

# Initialize models

config = JuliaPropertyMap()
config["max_steps"] = "10"
config["time_bound"] = "133.7"
config["state_formula"] = "!location"

roles = JuliaPropertyMap()

models = JuliaPropertyMap()

action_list::Vector{QAction} = [QAction("action")]
models["actions"] = JuliaItemModel(action_list)

agent_list::Vector{QAgent} = [QAgent("agent")]
models["agents"] = JuliaItemModel(agent_list)

variable_list::Vector{QVariable} = [QVariable("variable", "0")]
models["variables"] = JuliaItemModel(variable_list)
roles["name"] = roleindex(models["variables"], "name")

trigger_list::Vector{QTrigger} = [QTrigger("agent", "true")]
models["triggers"] = JuliaItemModel(trigger_list)

location_list::Vector{QLocation} = [QLocation("location", true, "true", JuliaItemModel([QFlow("variable", "variable + 1")]))]
models["locations"] = JuliaItemModel(location_list)
setsetter!(models["locations"], setflow!, roleindex(models["locations"], "flow"))

edge_list::Vector{QEdge} = [QEdge("location", "location", "true", "agent", "action", JuliaItemModel([QJump("variable", "variable + 1")]))]
models["edges"] = JuliaItemModel(edge_list)
setsetter!(models["edges"], setjump!, roleindex(models["edges"], "jump"))

query_list::Vector{QQuery} = [QQuery("<<agent>> F true")]
models["queries"] = JuliaItemModel(query_list)

# Initialize QML functions

"""
    name_available(name::QString)::Bool

Check whether a name is available (not used by any action, agent, variable or location).

# Arguments
- `name::QString`: the name to check
"""
function name_available(name::QString)::Bool
    return !any(v -> v.name == name, [action_list; agent_list; variable_list; location_list])
end

"""
    is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: the formula as a string
- `level::QString`: the parse level as a string (`expression`, `constraint`, `state` or `strategy`)
"""
function is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in agent_list],
        [x.name for x in location_list],
        [x.name for x in variable_list]
    )
    try
        parse(text, bindings, Symbol(eval(String(level))))
        return true
    catch
        return false
    end
end

"""
    save(path::QString)

Save the current game to a file given by `path`.

# Arguments
- `path::QString`: the file path to save to
"""
function save(path::QString)
    data::Dict{String,Union{Vector,Dict}} = Dict([
        "agents" => agent_list,
        "actions" => action_list,
        "variables" => variable_list,
        "triggers" => trigger_list,
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
            ) for loc in location_list
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
            ) for edge in edge_list
        ],
        "queries" => query_list,
        "config" => Dict([
            "max_steps" => config["max_steps"],
            "time_bound" => config["time_bound"],
            "state_formula" => config["state_formula"],
        ]),
    ])

    open(replace(String(path), r"^(file:\/{2})" => ""), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

"""
    load(path::QString)::String

Load a game from a file given by `path`.

# Arguments
- `path::QString`: the file path to load from
"""
function load(path::QString)::String
    function load_elements(name::String, type::Type, list::Vector)
        empty!(list)
        for element in data[name]
            push!(list, StructTypes.constructfrom(type, element))
        end
    end

    data = Dict{String,Any}()

    try
        data = open(replace(String(path), r"^(file:\/{2})" => ""), "r") do f
            JSON3.read(f)
        end
    catch e
        return String(strip(e.msg, ['\n', '\r', ' ']))
    end

    try
        load_elements("agents", QAgent, agent_list)
        load_elements("actions", QAction, action_list)
        load_elements("variables", QVariable, variable_list)
        load_elements("triggers", QTrigger, trigger_list)
        empty!(location_list)
        for loc in data["locations"]
            flow_list::Vector{QFlow} = Vector{QFlow}()
            for flow in loc["flow"]
                push!(flow_list, StructTypes.constructfrom(QFlow, flow))
            end
            push!(location_list, QLocation(loc["name"], loc["initial"], loc["invariant"], JuliaItemModel(flow_list)))
        end
        empty!(edge_list)
        for edge in data["edges"]
            jump_list::Vector{QJump} = Vector{QJump}()
            for jump in edge["jump"]
                push!(jump_list, StructTypes.constructfrom(QJump, jump))
            end
            push!(edge_list, QEdge(edge["source"], edge["target"], edge["guard"], edge["agent"], edge["action"], JuliaItemModel(jump_list)))
        end
        load_elements("queries", QQuery, query_list)

        config["max_steps"] = data["config"]["max_steps"]
        config["time_bound"] = data["config"]["time_bound"]
        config["state_formula"] = data["config"]["state_formula"]
    catch e
        return "invalid HYTRIG file: Missing key $(e.key)"
    end

    return ""
end

# TODO: write docs
function verify()::String
    bindings::Bindings = Bindings(
        [x.name for x in agent_list],
        [x.name for x in location_list],
        [x.name for x in variable_list]
    )
    # TODO: error handling
    locations = Vector{Location}([
        Location(
            Symbol(x.name),
            parse(x.invariant, bindings, constraint),
            ReAssignment(
                Variable(x.flow[i].variable) => parse(x.flow[i].expression, bindings, expression) for i in 1:length(x.flow)
            )
        ) for x in location_list
    ])
    initial_valuation = Valuation(
        Variable(x.name) => Base.parse(Float64, x.expression) for x in variable_list
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
        ) for (i, edge) in enumerate(edge_list)
    ])  
    triggers = Dict{Agent, Vector{Constraint}}()
    for x in trigger_list
        agent = Agent(x.agent)
        if !haskey(triggers, agent)
            triggers[agent] = Vector{Constraint}()
        end
        push!(triggers[agent], parse(x.trigger, bindings, constraint))
    end    
    game = Game(
        locations,
        locations[findfirst(loc -> loc.initial, location_list)],
        initial_valuation,
        [Agent(x.name) for x in agent_list],
        [Action(x.name) for x in action_list],
        edges,
        triggers,
        true
    )
    results::Vector{Bool}, game_tree::Node = evaluate_queries(
        game,
        Termination_Conditions(
            Base.parse(Float64, config["time_bound"]),
            Base.parse(Int64, config["max_steps"]),
            parse(config["state_formula"], bindings, state)
        ),
        Vector{Strategy_Formula}([parse(query.formula, bindings, strategy) for query in query_list])
    )

    for (i, query) in enumerate(query_list)
        query.verified = results[i]
    end

    return ""
end

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction name_available is_formula save load verify

loadqml(
    qml_file,
    roles=roles,
    config=config,
    models=models,
)

exec()
