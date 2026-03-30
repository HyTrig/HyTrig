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

export Constraint, Truth, Less, LeQ, Greater, GeQ, Equal, NotEqual, And, Or, Not, Imply
export RectConstr, RectTrue, RectLess, RectLessEq, RectGrt, RectGrtEq, RectEq, RectAnd
export constraint_to_string, is_closed, get_atomic_constraints, negation_normal_form, get_zero
export constraint_to_rect_constraint, strip_variables, round5

# abstract type for all constraints
abstract type Constraint end

# TODO: add type documentation
struct Truth <: Constraint
    value::Bool
end

# TODO: add type documentation
struct Less <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct LeQ <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct Greater <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct GeQ <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct Equal <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct NotEqual <: Constraint
    left::ExprLike
    right::ExprLike
end

# TODO: add type documentation
struct And <: Constraint
    left::Constraint
    right::Constraint
end

# TODO: add type documentation
struct Or <: Constraint
    left::Constraint
    right::Constraint
end

# TODO: add type documentation
struct Not <: Constraint
    constraint::Constraint
end

# TODO: add type documentation
struct Imply <: Constraint
    left::Constraint
    right::Constraint
end

# abstract type for rectangular constraints
abstract type RectConstr <: Constraint end

# TODO: add type documentation
struct RectTrue <: RectConstr
end

# TODO: add type documentation
struct RectLess <: RectConstr
    var::Variable
    value::Float64
end

# TODO: add type documentation
struct RectLessEq <: RectConstr
    var::Variable
    value::Float64
end

# TODO: add type documentation
struct RectGrt <: RectConstr
    var::Variable
    value::Float64
end

# TODO: add type documentation
struct RectGrtEq <: RectConstr
    var::Variable
    value::Float64
end

# TODO: add type documentation
struct RectEq <: RectConstr
    var::Variable
    value::Float64
end

# TODO: add type documentation
struct RectAnd <: RectConstr
    left::RectConstr
    right::RectConstr
end

# TODO: add function documentation
function constraint_to_string(constraint::Constraint)::String
    @match constraint begin
        Truth(value) => string(value)
        Less(left, right) => "($(expression_to_string(left)) < $(expression_to_string(right)))"
        LeQ(left, right) => "($(expression_to_string(left)) <= $(expression_to_string(right)))"
        Greater(left, right) => "($(expression_to_string(left)) > $(expression_to_string(right)))"
        GeQ(left, right) => "($(expression_to_string(left)) >= $(expression_to_string(right)))"
        Equal(left, right) => "($(expression_to_string(left)) == $(expression_to_string(right)))"
        NotEqual(left, right) => "($(expression_to_string(left)) != $(expression_to_string(right)))"
        And(left, right) => "($(constraint_to_string(left))) && ($(constraint_to_string(right)))"
        Or(left, right) => "($(constraint_to_string(left))) || ($(constraint_to_string(right)))"
        Not(c) => "!($(constraint_to_string(c)))"
        Imply(left, right) => "($(constraint_to_string(left))) -> ($(constraint_to_string(right)))"
    end
end

# TODO: add function documentation
function is_closed(constraint::Constraint)::Bool
    @match constraint begin
        Truth(_) => true
        Less(left, right) => false
        LeQ(left, right) => true
        Greater(left, right) => false
        GeQ(left, right) => true
        Equal(left, right) => true
        NotEqual(left, right) => false
        And(left, right) => is_closed(left) && is_closed(right)
        Or(left, right) => is_closed(left) && is_closed(right)
        Not(c) => ! is_closed(c)
        Imply(left, right) => is_closed(left) && is_closed(right)
    end
end

# TODO: add function documentation
function get_atomic_constraints(constraint::Constraint)::Vector{Constraint}
    @match constraint begin
        Truth(_) => [constraint]
        Less(left, right) => [constraint]
        LeQ(left, right) => [constraint]
        Greater(left, right) => [constraint]
        GeQ(left, right) => [constraint]
        Equal(left, right) => [constraint]
        NotEqual(left, right) => [constraint]
        And(left, right) => get_atomic_constraints(left) ∪ get_atomic_constraints(right)
        Or(left, right) => get_atomic_constraints(left) ∪ get_atomic_constraints(right)
        Not(c) => get_atomic_constraints(c)
        Imply(left, right) => get_atomic_constraints(left) ∪ get_atomic_constraints(right)
    end
end

# TODO: add function documentation
function negation_normal_form(constraint::Constraint)::Constraint
    @match constraint begin
        Not(Not(c)) => negation_normal_form(c)
        Not(And(left, right)) => Or(negation_normal_form(Not(left)), negation_normal_form(Not(right)))
        Not(Or(left, right)) => And(negation_normal_form(Not(left)), negation_normal_form(Not(right)))
        Not(Imply(left, right)) => And(negation_normal_form(left), negation_normal_form(Not(right)))
        Not(Truth(value)) => Truth(!value)
        And(left, right) => And(negation_normal_form(left), negation_normal_form(right))
        Or(left, right) => Or(negation_normal_form(left), negation_normal_form(right))
        Imply(left, right) => Or(negation_normal_form(Not(left)), negation_normal_form(right))
        Not(c) => Not(negation_normal_form(c))
        _ => constraint
    end
end

# TODO: add function documentation
function get_zero(constraint::Constraint)::Set{ExprLike}
    @match constraint begin
        Truth(true) => Set([Const(0)])
        Truth(false) => Set([Const(1)])
        LeQ(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        Less(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        GeQ(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        Greater(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        Equal(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        NotEqual(left, right) => Set([Sub(right, left), Sub(left, Add(right, Const(1e-5))), Sub(right, Add(left, Const(1e-5)))])
        And(left, right) => get_zero(left) ∪ get_zero(right)
        Or(left, right) => get_zero(left) ∪ get_zero(right)
        Not(c) => get_zero(c)
        Imply(left, right) => get_zero(left) ∪ get_zero(right)
    end
end

# TODO: add function documentation
function get_zero(constraints)::Set{ExprLike}
    return union_safe([get_zero(constr) for constr in constraints])
end

# TODO: add type documentation
struct RectConstrError <: Exception
    msg::AbstractString
end

# TODO: add function documentation
function constraint_to_rect_constraint(constr::Constraint)::RectConstr
    @match constr begin
        Truth(true) => RectTrue()
        LeQ(left::Var, right::Const) => RectLessEq(left.name, right.value)
        LeQ(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        LeQ(left::Const, right::Var) => RectLessEq(right.name, left.value)
        LeQ(Neg(val::Const), right::Var) => RectLessEq(right.name, - val.value)
        
        Less(left::Var, right::Const) => RectLess(left.name, right.value)
        Less(left::Var, Neg(val::Const)) => RectLess(left.name, - val.value)
        Less(left::Const, right::Var) => RectLess(right.name, left.value)
        Less(Neg(val::Const), right::Var) => RectLess(right.name, - val.value)

        GeQ(left::Var, right::Const) => RectGrtEq(left.name, right.value)
        GeQ(left::Var, Neg(val::Const)) => RectGrtEq(left.name, - val.value)
        GeQ(left::Var, right::Var) => RectGrtEq(right.name, left.value)
        GeQ(Neg(val::Const), right::Var) => RectGrtEq(right.name, - val.value)

        Greater(left::Var, right::Const) => RectGrt(left.name, right.value)
        Greater(left::Var, Neg(val::Const)) => RectGrt(left.name, - val.value)
        Greater(left::Const, right::Var) => RectGrt(right.name, left.value)
        Greater(Neg(val::Const), right::Var) => RectGrt(right.name, - val.value)

        Equal(left::Var, right::Const) => RectEq(left.name, right.value)
        Equal(left::Var, Neg(val::Const)) => RectEq(left.name, - val.value)
        Equal(left::Const, right::Var) => RectEq(right.name, left.value)
        Equal(Neg(val::Const), right::Var) => RectEq(right.name, - val.value)

        And(left, right) => RectAnd(constraint_to_rect_constraint(left), constraint_to_rect_constraint(right))
        _ => throw(ArgumentError("$(constraint_to_string(constr)) not a rectangular constraint."))
    end
end

# TODO: add function documentation
function strip_variables(constr::RectConstr, variables::Vector{Variable})::RectConstr
    @match constr begin
        RectTrue() => constr
        RectLess(var, _) => if var in variables RectTrue() else constr end
        RectLessEq(var, _) => if var in variables RectTrue() else constr end
        RectGrt(var, _) => if var in variables RectTrue() else constr end
        RectGrtEq(var, _) => if var in variables RectTrue() else constr end
        RectEq(var, _) => if var in variables RectTrue() else constr end
        RectAnd(left, right) => RectAnd(strip_variables(right, variables), strip_variables(left, variables))
    end
end

# TODO: add function documentation
function round5(constraint::Constraint, digits=5)::Constraint
    @match constraint begin
        Truth(value) => Truth(value)
        Less(left, right) => Less(round5(left, digits), round5(right, digits))
        LeQ(left, right) => LeQ(round5(left, digits), round5(right, digits))
        Greater(left, right) => Greater(round5(left, digits), round5(right))
        GeQ(left, right) => GeQ(round5(left, digits), round5(right, digits))
        Equal(left, right) => Equal(round5(left, digits), round5(right, digits))
        NotEqual(left, right) => NotEqual(round5(left, digits), round5(right, digits))
        And(left, right) => And(round5(left, digits), round5(right, digits))
        Or(left, right) => Or(round5(left, digits), round5(right, digits))
        Not(sub_constraint) => Not(round5(sub_constraint, digits))
    end
end

