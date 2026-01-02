"""
    HyTrig-GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

include("gui/packages.jl")

using QML

include("gui/qml_objects.jl")
include("src/parsers/syntax_parsers/parser.jl")

# Initialize models

roles = JuliaPropertyMap()

action_list::Vector{QAction} = [QAction("action")]
action_model::JuliaItemModel = JuliaItemModel(action_list)

agent_list::Vector{QAgent} = [QAgent("agent")]
agent_model::JuliaItemModel = JuliaItemModel(agent_list)

variable_list::Vector{QVariable} = [QVariable("variable", "0")]
variable_model::JuliaItemModel = JuliaItemModel(variable_list)
roles["variable_name"] = roleindex(variable_model, "name")

trigger_list::Vector{QTrigger} = [QTrigger("agent", "true")]
trigger_model::JuliaItemModel = JuliaItemModel(trigger_list)

location_list::Vector{QLocation} = [QLocation("location", true, "true", JuliaItemModel([QFlow("variable", "variable + 1")]))]
location_model::JuliaItemModel = JuliaItemModel(location_list)
setsetter!(location_model, setflow!, roleindex(location_model, "flow"))

edge_list::Vector{QEdge} = [QEdge("location", "location", "true", JuliaItemModel([QJump("variable", "variable + 1")]))]
edge_model::JuliaItemModel = JuliaItemModel(edge_list)
setsetter!(edge_model, setjump!, roleindex(edge_model, "jump"))

query_list::Vector{QQuery} = [QQuery("<<agent>> F true")]
query_model::JuliaItemModel = JuliaItemModel(query_list)

# Initialize QML functions

function name_available(name::QString)::Bool
    return !any(v -> v.name == name, [action_list; agent_list; variable_list; location_list])
end

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

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction name_available is_formula

loadqml(
    qml_file,
    roles=roles,
    action_model=action_model,
    agent_model=agent_model,
    variable_model=variable_model,
    trigger_model=trigger_model,
    location_model=location_model,
    edge_model=edge_model,
    query_model=query_model,
)

exec()
