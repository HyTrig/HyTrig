"""
    HyTrig-GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

include("gui/packages.jl")
include("gui/qml_objects.jl")

using QML

# Initialize models

action_list::Vector{QAction} = [QAction("action")]
agent_list::Vector{QAgent} = [QAgent("agent")]
variable_list::Vector{QVariable} = [QVariable("variable", "0")]
trigger_list::Vector{QTrigger} = [QTrigger("agent", "true")]

# Initialize QML functions

function name_available(name::QString)::Bool
    return !any(v -> v.name == name, [action_list; agent_list; variable_list])
end

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction name_available

loadqml(
    qml_file,
    action_model = JuliaItemModel(action_list),
    agent_model = JuliaItemModel(agent_list),
    variable_model = JuliaItemModel(variable_list),
    trigger_model = JuliaItemModel(trigger_list)
)

exec()
