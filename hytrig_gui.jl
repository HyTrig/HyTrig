"""
    HyTrig GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- Moritz Maas
"""

using Pkg

Pkg.activate(".")
Pkg.instantiate()

using JSON3, QML, StructTypes

include("src/hytrig.jl")
using .HyTrig
using .HyTrig: parse

include("gui/gui.jl")

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction hgt_up_tree hgt_down_tree
@qmlfunction hgt_is_formula hgt_name_available hgt_save hgt_load hgt_verify
@qmlfunction mhg_is_formula mhg_name_available mhg_save mhg_load mhg_verify

loadqml(
    qml_file,
    roles=roles,
    hgt_models=hgt_models,
    mhg_models=mhg_models,
)

exec()
