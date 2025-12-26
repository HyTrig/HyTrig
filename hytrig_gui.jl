"""
    HyTrig-GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

include("gui/packages.jl")
include("gui/qml_objects.jl")
include("src/parsers/syntax_parsers/parser.jl")

using QML

# Initialize models

action_list::Vector{QAction} = [QAction("action")]
agent_list::Vector{QAgent} = [QAgent("agent")]
variable_list::Vector{QVariable} = [QVariable("variable", "0")]
trigger_list::Vector{QTrigger} = []
location_list::Vector{QLocation} = []

# Initialize QML functions

function name_available(name::QString)::Bool
    return !any(v -> v.name == name, [action_list; agent_list; variable_list])
end

function is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in agent_list],
        [x.name for x in location_list],
        [x.name for x in variable_list]
    )
    try
        parse(text, bindings, Symbol(String(level)))
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
    action_model = JuliaItemModel(action_list),
    agent_model = JuliaItemModel(agent_list),
    variable_model = JuliaItemModel(variable_list),
    trigger_model = JuliaItemModel(trigger_list)
)

exec()
