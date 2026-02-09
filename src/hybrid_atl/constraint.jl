"""TODO: write docs"""

export Constraint, Truth, Less, LeQ, Greater, GeQ, Equal, NotEqual, And, Or, Not, Imply
export RectConstr, RectTrue, RectLess, RectLessEq, RectGrt, RectGrtEq, RectEq, RectAnd
export to_string, is_closed, get_atomic_constraints, negation_normal_form, get_zero
export constraint_to_rect_constraint, strip_variables, round5

abstract type Constraint end

struct Truth <: Constraint
    value::Bool
end

struct Less <: Constraint
    left::ExprLike
    right::ExprLike
end

struct LeQ <: Constraint
    left::ExprLike
    right::ExprLike
end

struct Greater <: Constraint
    left::ExprLike
    right::ExprLike
end

struct GeQ <: Constraint
    left::ExprLike
    right::ExprLike
end

struct Equal <: Constraint
    left::ExprLike
    right::ExprLike
end

struct NotEqual <: Constraint
    left::ExprLike
    right::ExprLike
end

struct And <: Constraint
    left::Constraint
    right::Constraint
end

struct Or <: Constraint
    left::Constraint
    right::Constraint
end

struct Not <: Constraint
    constraint::Constraint
end

struct Imply <: Constraint
    left::Constraint
    right::Constraint
end

abstract type RectConstr <: Constraint end

struct RectTrue <: RectConstr
end

struct RectLess <: RectConstr
    var::Variable
    value::Real
end

struct RectLessEq <: RectConstr
    var::Variable
    value::Real
end

struct RectGrt <: RectConstr
    var::Variable
    value::Real
end

struct RectGrtEq <: RectConstr
    var::Variable
    value::Real
end

struct RectEq <: RectConstr
    var::Variable
    value::Real
end

struct RectAnd <: RectConstr
    left::RectConstr
    right::RectConstr
end

function to_string(constraint::Constraint)::String
    @match constraint begin
        Truth(value) => string(value)
        Less(left, right) => "$(to_string(left)) < $(to_string(right))"
        LeQ(left, right) => "$(to_string(left)) <= $(to_string(right))"
        Greater(left, right) => "$(to_string(left)) > $(to_string(right))"
        GeQ(left, right) => "$(to_string(left)) >= $(to_string(right))"
        Equal(left, right) => "$(to_string(left)) == $(to_string(right))"
        NotEqual(left, right) => "$(to_string(left)) != $(to_string(right))"
        And(left, right) => "($(to_string(left))) ∧ ($(to_string(right)))"
        Or(left, right) => "($(to_string(left))) ∨ ($(to_string(right)))"
        Not(c) => "¬($(to_string(c)))"
        Imply(left, right) => "($(to_string(left))) → ($(to_string(right)))"
    end
end

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

function get_zero(constraint::Constraint)::Vector{ExprLike}
    @match constraint begin
        Truth(true) => ExprLike[Const(0)]
        Truth(false) => ExprLike[Const(1)]
        LeQ(left, right) => ExprLike[Sub(right, left), Sub(left, Add(right, Const(1e-5)))]
        Less(left, right) => ExprLike[Sub(right, Add(left, Const(1e-5))), Sub(left, right)]
        GeQ(left, right) => ExprLike[Sub(left, right), Sub(right, Add(left, Const(1e-5)))]
        Greater(left, right) => ExprLike[Sub(left, Add(right, Const(1e-5))), Sub(right, left)]
        Equal(left, right) => ExprLike[Sub(left, right)] ∪ get_zero(Greater(left, right)) ∪ get_zero(Less(left, right))
        NotEqual(left, right) => ExprLike[Sub(left, right)] ∪ get_zero(Greater(left, right)) ∪ get_zero(Less(left, right))
        And(left, right) => get_zero(left) ∪ get_zero(right)
        Or(left, right) => get_zero(left) ∪ get_zero(right)
        Not(c) => get_zero(c)
        Imply(left, right) => get_zero(left) ∪ get_zero(right)
    end
end

function get_zero(constraints)::Vector{ExprLike}
    return union_safe([get_zero(constr) for constr in constraints])
end

struct RectConstrError <: Exception
    msg::AbstractString
end

function constraint_to_rect_constraint(constr::Constraint)::RectConstr
    @match constr begin
        Truth(true) => RectTrue()
        LeQ(left::Var, right::Const) => RectLessEq(left.name, right.value)
        LeQ(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        Less(left::Var, right::Const) => RectLess(left.name, right.value)
        Less(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        GeQ(left::Var, right::Const) => RectGrtEq(left.name, right.value)
        GeQ(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        Greater(left::Var, right::Const) => RectGrt(left.name, right.value)
        Greater(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        Equal(left::Var, right::Const) => RectEq(left.name, right.value)
        Equal(left::Var, Neg(val::Const)) => RectLessEq(left.name, - val.value)
        And(left, right) => RectAnd(constraint_to_rect_constraint(left), constraint_to_rect_constraint(right))
        _ => throw(RectConstrError("Invalid Constraint $constr."))
    end
end

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

function round5(constraint::Constraint)::Constraint
    @match constraint begin
        Truth(value) => Truth(value)
        Less(left, right) => Less(round5(left), round5(right))
        LeQ(left, right) => LeQ(round5(left), round5(right))
        Greater(left, right) => Greater(round5(left), round5(right))
        GeQ(left, right) => GeQ(round5(left), round5(right))
        Equal(left, right) => Equal(round5(left), round5(right))
        NotEqual(left, right) => NotEqual(round5(left), round5(right))
        And(left, right) => And(round5(left), round5(right))
        Or(left, right) => Or(round5(left), round5(right))
        Not(constraint1) => Not(round5(constraint1))
    end
end
