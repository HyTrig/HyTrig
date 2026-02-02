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

# Initialize QML functions

"""
    is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: the formula as a string
- `level::QString`: the parse level as a string (`expression`, `constraint`, `state` or `strategy`)
"""
function is_formula(text::QString, level::QString)::Bool
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

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

@qmlfunction is_formula up_tree down_tree hgt_name_available hgt_save hgt_load hgt_verify mhg_name_available mhg_save mhg_load mhg_verify

loadqml(
    qml_file,
    roles=roles,
    tree=tree,
    hgt_models=hgt_models,
    mhg_models=mhg_models,
)

exec()
