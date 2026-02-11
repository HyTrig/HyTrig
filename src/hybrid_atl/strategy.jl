"""TODO: write docs"""

export Agent, Strategy_Formula, Strategy_to_State, Exist_Always, Exist_Eventually, All_Always, All_Eventually
export Strategy_And, Strategy_Or, Strategy_Not, Strategy_Imply, Strategy_Deadlock
export get_all_constraints, formula_to_rect_formula

const Agent = Symbol

abstract type Strategy_Formula <: Logic_Formula end

struct Strategy_to_State <: Strategy_Formula
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::Strategy_to_State, y::Strategy_to_State) = (
    x.formula == y.formula
)

struct Exist_Always <: Strategy_Formula
    agents::Vector{Agent}
    formula::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::Exist_Always, y::Exist_Always) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

struct Exist_Eventually <: Strategy_Formula
    agents::Vector{Agent}
    formula::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::Exist_Eventually, y::Exist_Eventually) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

struct All_Always <: Strategy_Formula
    agents::Vector{Agent}
    formula::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::All_Always, y::All_Always) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

struct All_Eventually <: Strategy_Formula
    agents::Vector{Agent}
    formula::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::All_Eventually, y::All_Eventually) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

struct Strategy_And <: Strategy_Formula
    left::Strategy_Formula
    right::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::Strategy_And, y::Strategy_And) = (
    x.left == y.left &&
    x.right == y.right
)

struct Strategy_Or <: Strategy_Formula
    left::Strategy_Formula
    right::Strategy_Formula
end


struct Strategy_Not <: Strategy_Formula
    formula::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::Strategy_Not, y::Strategy_Not) = (
    x.formula == y.formula
)

struct Strategy_Imply <: Strategy_Formula
    left::Strategy_Formula
    right::Strategy_Formula
end

# redefine comparison
Base.:(==)(x::Strategy_Imply, y::Strategy_Imply) = (
    x.left == y.left &&
    x.right == y.right
)

struct Strategy_Deadlock <: Strategy_Formula
end

function get_all_constraints(formula::Strategy_Formula)::Vector{Constraint}
    @match formula begin
        Strategy_to_State(f) => get_all_constraints(f)
        Exist_Always(_, f) => get_all_constraints(f)
        Exist_Eventually(_, f) => get_all_constraints(f)
        All_Always(_, f) => get_all_constraints(f)
        All_Eventually(_, f) => get_all_constraints(f)
        Strategy_And(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        Strategy_Or(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        Strategy_Not(f) => get_all_constraints(f)
        Strategy_Imply(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        Strategy_Deadlock() => Vector{Constraint}()
    end
end

function get_all_constraints(formulae::Vector{Logic_Formula})::Vector{Constraint}
    return union_safe([get_all_constraints(formula) for formula in formulae])
end

function formula_to_rect_formula(formula::Strategy_Formula)::Union{Bool, Strategy_Formula}
    @match formula begin
        Strategy_to_State(f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, State_Formula)
                Strategy_to_State(inner_formula)
            else
                false
            end
        end
        Exist_Always(a, f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, Strategy_Formula)
                Exist_Always(a, inner_formula)
            else
                false
            end
        end
        Exist_Eventually(a, f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, Strategy_Formula)
                Exist_Eventually(a, inner_formula)
            else
                false
            end
        end
        All_Always(a, f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, Strategy_Formula)
                All_Always(a, inner_formula)
            else
                false
            end
        end
        All_Eventually(a, f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, Strategy_Formula)
                All_Always(a, inner_formula)
            else
                false
            end
        end
        Strategy_And(left, right) => begin
            left_formula = formula_to_rect_formula(left)
            right_formula = formula_to_rect_formula(right)
            if isa(left_formula, Strategy_Formula) && isa(right_formula, Strategy_Formula) 
                Strategy_And(left_formula, right_formula)
            else
                false
            end
        end
        Strategy_Or(left, right) => begin
            left_formula = formula_to_rect_formula(left)
            right_formula = formula_to_rect_formula(right)
            if isa(left_formula, Strategy_Formula) && isa(right_formula, Strategy_Formula) 
                Strategy_Or(left_formula, right_formula)
            else
                false
            end
        end
        Strategy_Not(f) => begin
            inner_formula = formula_to_rect_formula(f)
            if isa(inner_formula, Strategy_Formula)
                Strategy_Not(inner_formula)
            else
                false
            end
        end
        Strategy_Imply(left, right) => begin
            left_formula = formula_to_rect_formula(left)
            right_formula = formula_to_rect_formula(right)
            if isa(left_formula, Strategy_Formula) && isa(right_formula, Strategy_Formula) 
                Strategy_Imply(left_formula, right_formula)
            else
                false
            end
        end
        Strategy_Deadlock() => Strategy_Deadlock()
    end
end
