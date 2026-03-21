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

export State_Formula, State_Location, State_Constraint, State_And, State_Or, State_Not, State_Imply, State_Deadlock
export get_all_constraints, formula_to_rect_formula, state_to_string

# abstract type for all state formulas
abstract type State_Formula <: Logic_Formula end

# TODO: add type documentation
struct State_Location <: State_Formula
    proposition::Symbol
end

# TODO: add type documentation
struct State_Constraint <: State_Formula
    constraint::Constraint
end

# TODO: add type documentation
struct State_And <: State_Formula
    left::State_Formula
    right::State_Formula
end

# TODO: add type documentation
struct State_Or <: State_Formula
    left::State_Formula
    right::State_Formula
end

# TODO: add type documentation
struct State_Not <: State_Formula
    formula::State_Formula
end

# TODO: add type documentation
struct State_Imply <: State_Formula
    left::State_Formula
    right::State_Formula
end

function get_all_constraints(formula::State_Formula)::Set{Constraint}
    @match formula begin
        State_Location(_) => Set{Constraint}()
        State_Constraint(constraint) => Set([constraint])
        State_And(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        State_Or(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        State_Not(subformula) => get_all_constraints(subformula)
        State_Imply(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
    end
end

# TODO: add function documentation
function formula_to_rect_formula(formula::State_Formula)::State_Formula
    @match formula begin
        State_Location(_) => formula
        State_Constraint(constraint) => State_Constraint(constraint_to_rect_constraint(constraint))
        State_And(left, right) => State_And(formula_to_rect_formula(left), formula_to_rect_formula(right))
        _ => throw(ArgumentError("$(state_to_string(formula)) not a rectangular state formula."))
    end
end

# TODO: add function documentation
function state_to_string(formula::State_Formula)::String
    @match formula begin
        State_Location(loc) => String(loc)
        State_Constraint(constraint) => constraint_to_string(constraint)
        State_And(left, right) => "($(state_to_string(left)) && $(state_to_string(right)))"
        State_Or(left, right) => "($(state_to_string(left)) || $(state_to_string(right)))"
        State_Not(subformula) => "!$(state_to_string(subformula))"
        State_Imply(left, right) => "($(state_to_string(left)) -> $(state_to_string(right)))"
    end
end
