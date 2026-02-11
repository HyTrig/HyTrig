"""TODO: write docs"""

export State_Formula, State_Location, State_Constraint, State_And, State_Or, State_Not, State_Imply
export get_all_constraints, formula_to_rect_formula

abstract type State_Formula <: Logic_Formula end

struct State_Location <: State_Formula
    proposition::Symbol
end

struct State_Constraint <: State_Formula
    constraint::Constraint
end

struct State_And <: State_Formula
    left::State_Formula
    right::State_Formula
end

struct State_Or <: State_Formula
    left::State_Formula
    right::State_Formula
end

struct State_Not <: State_Formula
    formula::State_Formula
end

struct State_Imply <: State_Formula
    left::State_Formula
    right::State_Formula
end

function get_all_constraints(formula::State_Formula)::Vector{Constraint}
    @match formula begin
        State_Location(_) => Vector{Constraint}()
        State_Constraint(constraint) => Vector([constraint])
        State_And(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        State_Or(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        State_Not(subformula) => get_all_constraints(subformula)
        State_Imply(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
    end
end

function formula_to_rect_formula(formula::State_Formula)::Union{Bool, State_Formula}
    @match formula begin
        State_Location(_) => formula
        State_Constraint(constraint) => begin
            rect_constr = constraint_to_rect_constraint(constraint)
            if isa(rect_constr, RectConstr)
                State_Constraint(rect_constr)
            else
                false
            end
        end
        State_And(left, right) => begin
            left_constr = formula_to_rect_formula(left)
            right_constr = formula_to_rect_formula(right)
            if isa(left_constr, State_Formula) && isa(right_constr, State_Formula) 
                State_And(left_constr, right_constr)
            else
                false
            end
        end
        _ => false
    end
end
