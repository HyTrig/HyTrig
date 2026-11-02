"""
    HyTrig GUI

This script runs a GUI with QML. The GUI allows to create, edit, save, load and verify hybrid games with triggers.

# Authors:
- 
"""

using Pkg

Pkg.activate(".")
Pkg.instantiate()

using JSON3, DataStructures, QML, StructTypes, Logging

include("src/hgtmc.jl")
using .HgtMc
using .HgtMc: parse

include("gui/gui.jl")

# Build and run QML GUI

qml_file = joinpath(dirname(@__FILE__), "gui", "qml", "GUI.qml")

"""
    ListModelResetLogger

Filters out the benign `row 0 is out of range for listmodel` warning that QML.jl
emits whenever a Qt view queries its "no current item" sentinel index against a
`JuliaItemModel`. This fires (harmlessly) whenever a tab is force-refreshed via
the `model = []; model = X` pattern used after loading a game, since QML.jl
converts Qt's -1 "no selection" index to a Julia row of 0 and reports it as
out-of-range instead of treating it as a normal "nothing selected" query.
"""
struct ListModelResetLogger <: Logging.AbstractLogger
    logger::Logging.AbstractLogger
end

Logging.min_enabled_level(l::ListModelResetLogger) = Logging.min_enabled_level(l.logger)
Logging.shouldlog(l::ListModelResetLogger, level, _module, group, id) = Logging.shouldlog(l.logger, level, _module, group, id)
Logging.catch_exceptions(l::ListModelResetLogger) = Logging.catch_exceptions(l.logger)

function Logging.handle_message(l::ListModelResetLogger, level, message, _module, group, id, file, line; kwargs...)
    if _module === QML && level == Logging.Warn && string(message) == "row 0 is out of range for listmodel"
        return
    end
    Logging.handle_message(l.logger, level, message, _module, group, id, file, line; kwargs...)
end

global_logger(ListModelResetLogger(current_logger()))

@qmlfunction hgt_set_tree hgt_up_tree hgt_down_tree hgt_save_tree hgt_save_trees
@qmlfunction hgt_is_formula hgt_is_closed hgt_name_available hgt_save hgt_load hgt_verify
@qmlfunction mhg_is_formula mhg_name_available mhg_save mhg_load mhg_verify

loadqml(
    qml_file,
    roles=roles,
    hgt_models=hgt_models,
    mhg_models=mhg_models,
)

exec()
