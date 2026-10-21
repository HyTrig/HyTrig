"""
    HGT GUI

This file contains all definitions related to Hybrid Games with Triggers in the GUI of HyTrig.

# Global variables:
- `hgt_models::JuliaPropertyMap`: A map to store item models of HGT objects.
- `hgt_tree::Vector{Union{Node, GUINode}}`: The verification trees of a Hybrid Game with Triggers.
- `hgt_tree_string::Vector{String}`: The string representation of the verification tree of a Hybrid Game with Triggers.
- `current_query::Int64`: The index of the currently displayed query in the GUI.

# Authors:
- 
"""

"""
    hgt_models::JuliaPropertyMap

A map to store item models of HGT objects.
"""
hgt_models::JuliaPropertyMap = JuliaPropertyMap()


include("hgt_tree.jl")
include("hgt_objects.jl")

"""
    hgt_tree::Vector{Union{Node, GUINode}}

The verification trees of a Hybrid Game with Triggers.
"""
hgt_tree::Vector{Union{Node, GUINode}} = []

"""
    hgt_tree_string::Vector{String}

The string representation of the verification tree of a Hybrid Game with Triggers.
"""
hgt_tree_string::Vector{String} = []

"""
    current_query::Int

The index of the currently displayed query in the GUI.
"""
current_query::Int = -1

include("hgt_functions.jl")
