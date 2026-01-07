"""
    HyTrig-GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

include("gui/packages.jl")

using JSON3
using QML

include("gui/qml_objects.jl")
# include("src/parsers/syntax_parsers/parser.jl")

# Initialize models

config = JuliaPropertyMap()
config["max_steps"] = ""
config["time_bound"] = ""
config["state_formula"] = ""

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

# TODO: write docs
function name_available(name::QString)::Bool
    return !any(v -> v.name == name, [action_list; agent_list; variable_list; location_list])
end

# TODO: write docs
function is_formula(text::QString, level::QString)::Bool
    # bindings::Bindings = Bindings(
    #     [x.name for x in agent_list],
    #     [x.name for x in location_list],
    #     [x.name for x in variable_list]
    # )
    # try
    #     parse(text, bindings, Symbol(eval(String(level))))
    #     return true
    # catch
    #     return false
    # end
    return true
end

# TODO: write docs
function save(path::QString)
    path = path
    data = agent_list
    open(String(path.toLocalFile()), "w") do f
        write(f, data)
    end
end

# TODO: write docs
function load(path::QString)
end

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction name_available is_formula save load

loadqml(
    qml_file,
    roles=roles,
    config=config,
    models=models,
)

exec()
