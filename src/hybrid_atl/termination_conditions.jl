include("logic.jl")

struct Termination_Conditions
    time_limit::Real
    max_steps::Int64
    state_formula::State_Formula
end