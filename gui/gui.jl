"""
    GUI

This file contains all definitions related to the GUI of HyTrig.

# Global variables:
- `roles::JuliaPropertyMap`: A map to store the index of object roles.

# Authors:
- 
"""

"""
    roles::JuliaPropertyMap

A map to store the index of object roles.
Used to access data in QML with `data()`.
"""
roles::JuliaPropertyMap = JuliaPropertyMap()

include("hgt/hgt_gui.jl")
include("mhg/mhg_gui.jl")
