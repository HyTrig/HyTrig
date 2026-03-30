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

export Strategy_Formula, Strategy_to_State, Exist_Always, Exist_Eventually, All_Always, All_Eventually
# export Strategy_And, Strategy_Or, Strategy_Not, Strategy_Imply, Strategy_Deadlock
export get_all_constraints, formula_to_rect_formula, strategy_to_string


# abstract type for all strategy formulas
abstract type Strategy_Formula <: Logic_Formula end

# TODO: add type documentation
struct Strategy_to_State <: Strategy_Formula
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::Strategy_to_State, y::Strategy_to_State) = (
    x.formula == y.formula
)

struct Exist_Always <: Strategy_Formula
    agents::Vector{Agent}
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::Exist_Always, y::Exist_Always) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

# TODO: add type documentation
struct Exist_Eventually <: Strategy_Formula
    agents::Vector{Agent}
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::Exist_Eventually, y::Exist_Eventually) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

# TODO: add type documentation
struct All_Always <: Strategy_Formula
    agents::Vector{Agent}
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::All_Always, y::All_Always) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

# TODO: add type documentation
struct All_Eventually <: Strategy_Formula
    agents::Vector{Agent}
    formula::State_Formula
end

# redefine comparison
Base.:(==)(x::All_Eventually, y::All_Eventually) = (
    x.agents == y.agents &&
    x.formula == y.formula
)

# struct Strategy_And <: Strategy_Formula
#     left::Strategy_Formula
#     right::Strategy_Formula
# end

# # redefine comparison
# Base.:(==)(x::Strategy_And, y::Strategy_And) = (
#     x.left == y.left &&
#     x.right == y.right
# )

# struct Strategy_Or <: Strategy_Formula
#     left::Strategy_Formula
#     right::Strategy_Formula
# end


# struct Strategy_Not <: Strategy_Formula
#     formula::Strategy_Formula
# end

# # redefine comparison
# Base.:(==)(x::Strategy_Not, y::Strategy_Not) = (
#     x.formula == y.formula
# )

# struct Strategy_Imply <: Strategy_Formula
#     left::Strategy_Formula
#     right::Strategy_Formula
# end

# # redefine comparison
# Base.:(==)(x::Strategy_Imply, y::Strategy_Imply) = (
#     x.left == y.left &&
#     x.right == y.right
# )

# struct Strategy_Deadlock <: Strategy_Formula
# end

function get_all_constraints(formula::Strategy_Formula)::Set{Constraint}
    @match formula begin
        Strategy_to_State(f) => get_all_constraints(f)
        Exist_Always(_, f) => begin
            if isa(f, State_Formula) 
                get_all_constraints(f)
            else 
                Set([])
            end
        end
        Exist_Eventually(_, f) => begin
            if isa(f, State_Formula) 
                get_all_constraints(f)
            else 
                Set([])
            end
        end
        All_Always(_, f) => begin
            if isa(f, State_Formula) 
                get_all_constraints(f)
            else 
                Set([])
            end
        end
        All_Eventually(_, f) => begin
            if isa(f, State_Formula) 
                get_all_constraints(f)
            else 
                Set([])
            end
        end
        # Strategy_And(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        # Strategy_Or(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        # Strategy_Not(f) => get_all_constraints(f)
        # Strategy_Imply(left, right) => get_all_constraints(left) ∪ get_all_constraints(right)
        # Strategy_Deadlock() => Set{Constraint}()
    end
end

function get_all_constraints(formulae::Vector{Logic_Formula})::Set{Constraint}
    return union_safe([get_all_constraints(formula) for formula in formulae])
end

# TODO: add function documentation
function formula_to_rect_formula(formula::Strategy_Formula)::Strategy_Formula
    @match formula begin
        Strategy_to_State(f) => Strategy_to_State(formula_to_rect_formula(f))
        Exist_Always(a, f) => Exists_Always(a, formula_to_rect_formula(f))
        Exist_Eventually(a, f) => Exist_Eventually(a, formula_to_rect_formula(f))
        All_Always(a, f) => All_Always(a, formula_to_rect_formula(f))
        All_Eventually(a, f) => All_Eventually(a, formula_to_rect_formula(f))
        # Strategy_And(left, right) => Strategy_And(formula_to_rect_formula(left), formula_to_rect_formula(right))
        # Strategy_Or(left, right) => Strategy_Or(formula_to_rect_formula(left), formula_to_rect_formula(right))
        # Strategy_Not(f) => Strategy_Not(formula_to_rect_formula(f))
        # Strategy_Imply(left, right) => Strategy_Imply(formula_to_rect_formula(left), formula_to_rect_formula(right))
        # Strategy_Deadlock() => Strategy_Deadlock()
    end
end

function agents_to_string(agents::Vector{Agent})
    str = ""
    for agent in agents
        str *= String(agent) * " "
    end
    str
end

function strategy_to_string(formula::Strategy_Formula)
    @match formula begin
        Strategy_to_State(f) => state_to_string(f)
        Exist_Always(a, f) => "<<$(agents_to_string(a))>> G $(state_to_string(f))"
        Exist_Eventually(a, f) => "<<$(agents_to_string(a))>> F $(state_to_string(f))"
        All_Always(a, f) => "[[$(agents_to_string(a))]] G $(state_to_string(f))"
        All_Eventually(a, f) => "[[$(agents_to_string(a))]] F $(state_to_string(f))"
    end
end