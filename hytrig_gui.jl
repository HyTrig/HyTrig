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

variable_list::Vector{QVariable} = []

# Initialize QML functions

function hasName(name::QString)::Bool
    name = String(name)
    println(name)
    return any(v -> v.name == name, variable_list)
end

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction hasName

loadqml(
    qml_file,
    variable_model = JuliaItemModel(variable_list)
)

exec()
