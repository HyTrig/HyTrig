"""
    TODO
"""

mutable struct QAction
    name::String
end

mutable struct QAgent
    name::String
end

mutable struct QVariable
    name::String
    value::String
end

mutable struct QTrigger
    agent::String
    action::String
end
