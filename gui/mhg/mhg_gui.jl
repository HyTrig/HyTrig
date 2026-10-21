"""
    MHG GUI

This file contains all definitions related to Monotonic Hybrid Games in the GUI of HyTrig.

# Global variables:
- `mhg_models::JuliaPropertyMap`: A map to store item models of MHG objects.

# Authors:
- 
"""

"""
    mhg_models::JuliaPropertyMap

A map to store item models of MHG objects.
"""
mhg_models::JuliaPropertyMap = JuliaPropertyMap()

include("mhg_objects.jl")
include("mhg_functions.jl")
