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

include("src/parsers/syntax_parsers/parser.jl")
include("gui/gui_tree.jl")

roles = JuliaPropertyMap()

include("gui/qml_objects/hgt_objects.jl")
include("gui/qml_objects/mhg_objects.jl")

tree = JuliaPropertyMap()

branch_list::Vector{QBranch} = []
tree["branches"] = JuliaItemModel(branch_list)

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction up_tree down_tree hgt_is_formula hgt_name_available hgt_save hgt_load hgt_verify mhg_is_formula mhg_name_available mhg_save mhg_load mhg_verify

loadqml(
    qml_file,
    roles=roles,
    tree=tree,
    hgt_models=hgt_models,
    mhg_models=mhg_models,
)

exec()
