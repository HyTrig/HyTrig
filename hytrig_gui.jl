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

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

loadqml(
    qml_file,
    variable_model = JuliaItemModel(variable_list)
)

exec()
