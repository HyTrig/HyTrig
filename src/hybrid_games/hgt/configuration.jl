"""
TODO: document this file by filling out the form below

    File Name
    
File description.

# Types:
- `MyType`: Description of MyType.

# Constants:
- `my_constant::Int`: Description of my_constant.

# Functions:
- `foo(x::String)::Bool`: Do foo.

# Global variables:
- `my_global_variable::Int`: Description of my_global_variable.

# Authors:
- Author 1
- Author 2
"""

export Configuration, initial_configuration

struct Configuration <: State
    location::Location
    valuation::Valuation
    global_clock::Float64
end

function initial_configuration(game::HGT_Game)::Configuration
    Configuration(game.initial_location, 
                  game.initial_valuation,
                  0.0)
end

# redefine comparison
Base.:(==)(x::Configuration, y::Configuration) = (
    x.location.name == y.location.name &&
    x.valuation == y.valuation &&
    x.global_clock == y.global_clock
)
