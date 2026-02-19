"""
    HGT GUI

This file contains all definitions related to Hybrid Games with Triggers in the GUI of HyTrig.

# Global variables:
- `hgt_models::JuliaPropertyMap`: A map to store item models of HGT objects.
- `hgt_tree::Union{Nothing, Node, GUINode}`: The verification tree of a Hybrid Game with Triggers.

# Authors:
- Moritz Maas
"""

"""
    hgt_models::JuliaPropertyMap

A map to store item models of HGT objects.
"""
hgt_models::JuliaPropertyMap = JuliaPropertyMap()


include("hgt_tree.jl")
include("hgt_objects.jl")

"""
    hgt_tree::Union{Nothing, Node, GUINode}

The verification tree of a Hybrid Game with Triggers.
"""
hgt_tree::Union{Nothing, Node, GUINode} = nothing

include("hgt_functions.jl")
