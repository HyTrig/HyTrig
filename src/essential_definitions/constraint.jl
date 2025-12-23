include("expression.jl")
include("interval.jl")

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

############################
############################

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

############################
############################

abstract type RectConstr <: Constraint end

struct RectLess <: RectConstr
    var::Var
    value::Const
end

struct RectLessEq <: RectConstr
    var::Var
    value::Const
end

struct RectGrt <: RectConstr
    var::Var
    value::Const
end

struct RectGrtEq <: RectConstr
    var::Var
    value::Const
end

struct RectEq <: RectConstr
    var::Var
    value::Const
end

struct RectAnd <: RectConstr
    left::RectConstr
    right::RectConstr
end

############################
############################

function str(constraint::Constraint)::String
    @match constraint begin
        Truth(value) => string(value)
        Less(left, right) => "$(str(left)) < $(str(right))"
        LeQ(left, right) => "$(str(left)) <= $(str(right))"
        Greater(left, right) => "$(str(left)) > $(str(right))"
        GeQ(left, right) => "$(str(left)) >= $(str(right))"
        Equal(left, right) => "$(str(left)) == $(str(right))"
        NotEqual(left, right) => "$(str(left)) != $(str(right))"
        And(left, right) => "($(str(left))) ∧ ($(str(right)))"
        Or(left, right) => "($(str(left))) ∨ ($(str(right)))"
        Not(c) => "¬($(str(c)))"
        Imply(left, right) => "($(str(left))) → ($(str(right)))"
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

function evaluate(constraint::Constraint, valuation::Valuation)::Bool
    @match constraint begin
        Truth(value) => value
        Less(left, right) => evaluate(left, valuation) < evaluate(right, valuation)
        LeQ(left, right) => evaluate(left, valuation) <= evaluate(right, valuation)
        Greater(left, right) => evaluate(left, valuation) > evaluate(right, valuation)
        GeQ(left, right) => evaluate(left, valuation) >= evaluate(right, valuation)
        Equal(left, right) => evaluate(left, valuation) == evaluate(right, valuation)
        NotEqual(left, right) => evaluate(left, valuation) != evaluate(right, valuation)
        And(left, right) => evaluate(left, valuation) && evaluate(right, valuation)
        Or(left, right) => evaluate(left, valuation) || evaluate(right, valuation)
        Not(c) => !evaluate(c, valuation)
        Imply(left, right) => !evaluate(left, valuation) || evaluate(right, valuation)
    end
end

function get_satisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> evaluate(constraint, valuation), constraints)
end

function get_unsatisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> ! evaluate(constraint, valuation), constraints)
end

if !isdefined(Main, :IntervalAssignment)
    const IntervalAssignment = OrderedDict{Variable, Interval}
end

function trim_rect_constr(constr::RectConstr, assignment::IntervalAssignment)::IntervalAssignment
    @match constr begin
        RectLess(var, val) => begin
            if val.value <= assignment[var.name].right
                assignment[var.name] = Interval(assignment[var.name].left, assignment[var.name].left_open, val.value, true)
            end
        end
        RectLessEq(var, val) => begin
            if val.value < assignment[var.name].right
                assignment[var.name] = Interval(assignment[var.name].left, assignment[var.name].left_open, val.value, false)
            end
        end
        RectGrt(var, val) => begin
            if val.value >= assignment[var.name].left
                assignment[var.name] = Interval(val.value, true, assignment[var.name].right, assignment[var.name].right_open)
            end
        end
        RectGrtEq(var, val) => begin
            if val.value > assignment[var.name].left
                assignment[var.name] = Interval(val.value, false, assignment[var.name].right, assignment[var.name].right_open)
            end
        end
        RectEq(var, val) => begin
            if val.value > assignment[var.name].left
                assignment[var.name] = Interval(val.value, false, val.value, false)
            end
        end
        RectAnd(left, right) => trim_rect_constr(right, trim_rect_constr(left, assignment))
    end
    assignment
end

# interval_1 = Interval(1.0, false, 5.0, false)
# interval_2 = Interval(0.0, false, 1.0, true)
# interval_3 = Interval(3.0, true, 7.0, false)
# interval_4 = Interval(-9.0, true, -5.0, true)

# assignment_1 = OrderedDict(:x => interval_1, :y => interval_2)

# println(trim_rect_constr(RectAnd(RectLessEq(Var(:x), Const(3)), RectLess(Var(:x), Const(3))), assignment_1))

# function intersect(assignment_1::IntervalAssignment, assignment_2::IntervalAssignment)
#     assignment::IntervalAssignment = OrderedDict{}()
#     for (var, intervals_1) in assignment_1
#         assignment[var] = intersect(intervals_1, assignment_2[var])
#     end
#     return assignment
# end

# function union(assignment_1::IntervalAssignment, assignment_2::IntervalAssignment)
#     assignment::IntervalAssignment = OrderedDict{}()
#     for (var, intervals_1) in assignment_1
#         assignment[var] = union(intervals_1, assignment_2[var])
#     end
#     return assignment
# end

# function get_interval(constraint::Constraint, assignment::IntervalAssignment)::IntervalAssignment
#     assignment::IntervalAssignment = OrderedDict{}()
#     @match constraint begin
#         Truth(value) => begin
#             if value 
#                 for var in variables
#                     assignment[var] = [Interval(-Inf, true, Inf, true)]
#                 end
#             else 
#                 for var in variables
#                     assignment[var] = [Interval(0, true, 0, true)]
#                 end
#             end
#             return assignment
#         end
#         Less(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(-Inf, true, right.value, true)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#                 return assignment
#             else 
#                 return get_interval(Less(right, left), variables)
#             end
#         end
#         LeQ(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(-Inf, true, right.value, false)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#                 return assignment
#             else 
#                 return get_interval(LeQ(right, left), variables)
#             end
#         end
#         Greater(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(right.value, true, Inf, true)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#             else 
#                 return get_interval(Greater(right, left), variables)
#             end
#         end
#         GeQ(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(right.value, false, Inf, true)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#             else 
#                 return get_interval(GeQ(right, left), variables)
#             end
#         end
#         Equal(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(right.value, false, right.value, false)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#             else 
#                 return get_interval(Equal(right, left), variables)
#             end
#         end
#         NotEqual(left, right) => begin
#             if isa(left, Var) 
#                 for var in variables
#                     if left.name == var 
#                         assignment[var] = [Interval(-Inf, true, right.value, true), 
#                                            Interval(right.value, true, Inf, true)]
#                     else 
#                         assignment[var] = [Interval(-Inf, true, Inf, true)]
#                     end
#                 end
#             else 
#                 return get_interval(Equal(right, left), variables)
#             end
#         end
#         And(left, right) => intersect(get_interval(left, variables), get_interval(right, variables))
#         Or(left, right) => union(get_interval(left, variables), get_interval(right, variables))
#         Not(c) => !evaluate(c, valuation)
#         Imply(left, right) => get_interval(Or(Not(left), right),variables)
#     end
# end

# function get_interval(constraint::RectConstr, assignment::IntervalAssignment)::IntervalAssignment

# end