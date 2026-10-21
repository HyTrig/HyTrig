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

export Interval, interval_to_string, in_interval, is_empty, empty_interval, full_interval, intersection
export MonotonError, Monoton, positive, negative, not_monoton, monoton_interval
export IntervalAssignment, constraint_to_assignment

# TODO: add type documentation
struct Interval
    left::Float64
    left_open::Bool
    right::Float64
    right_open::Bool
end

# redefine comparison
Base.:(==)(x::Interval, y::Interval) = (
    round4(x.left) == round4(y.left) && round4(x.right) == round4(y.right) &&
    x.left_open == y.left_open && x.right_open == y.right_open
)

# TODO: add function documentation
function interval_to_string(interval::Interval)::String
    res = if interval.left_open "(" else "[" end
    res *= "$(interval.left), $(interval.right)"
    res *= if interval.right_open ")" else "]" end
    res
end

# TODO: add function documentation
function in_interval(num::Real, interval::Interval)::Bool
    if num == interval.left 
        !interval.left_open
    elseif num == interval.right
        !interval.right_open
    else
        interval.left < num < interval.right
    end
end

# TODO: add function documentation
function is_empty(interval::Interval)::Bool
    interval.left > interval.right || (interval.left == interval.right && (interval.left_open || interval.right_open))
end

# TODO: add function documentation
function empty_interval()::Interval
    return Interval(0, true, 0, true)
end

# TODO: add function documentation
function full_interval()::Interval
    return Interval(-Inf, true, Inf, true)
end

# TODO: add function documentation
function zero_interval()::Interval
    return Interval(0, false, 0, false)
end

# TODO: add function documentation
function intersection(interval_1::Interval, interval_2::Interval)::Interval
    if interval_1.left > interval_2.left 
        left = interval_1.left
        left_open = interval_1.left_open
    elseif interval_2.left > interval_1.left
        left = interval_2.left
        left_open = interval_2.left_open
    else 
        left = interval_1.left
        left_open = interval_1.left_open || interval_2.left_open
    end
    if interval_1.right < interval_2.right 
        right = interval_1.right
        right_open = interval_1.right_open
    elseif interval_2.right < interval_1.right
        right = interval_2.right
        right_open = interval_2.right_open
    else 
        right = interval_1.right
        right_open = interval_1.right_open || interval_2.right_open
    end
    return Interval(left, left_open, right, right_open)
end

# TODO: add function documentation
function intersection(intervals::Vector{Interval})::Interval
    interval = full_interval()
    for interv in intervals
        interval = intersection(interval, interv)
    end
    interval
end

# TODO: rename to monotonic
# TODO: add type documentation
struct MonotonError <: Exception
    msg::AbstractString
end

@enum Monoton begin
    positive
    negative
    not_monoton
end

# TODO: add function documentation
function monoton_interval(interval::Interval)::Monoton
    if interval.left <= 0 && interval.right <= 0
        return negative
    elseif interval.left >= 0 && interval.right >= 0
        return positive
    else
        return not_monoton
    end
end

# TODO: add constant documentation
const IntervalAssignment = OrderedDict{Variable, Interval}

# TODO: add function documentation
function constraint_to_assignment(constr::RectConstr, variables::Vector{Variable})::IntervalAssignment
    assignment = OrderedDict(var => Interval(-Inf, true, Inf, true) for var in variables)
    return _constraint_to_assignment(constr, assignment)
end

# TODO: add function documentation
function _constraint_to_assignment(constr::RectConstr, assignment::IntervalAssignment)::IntervalAssignment
    @match constr begin
        RectTrue() => assignment
        RectLess(var, val) => begin
            if val <= assignment[var].right
                assignment[var] = Interval(assignment[var].left, assignment[var].left_open, val, true)
            end
        end
        RectLessEq(var, val) => begin
            if val < assignment[var].right
                assignment[var] = Interval(assignment[var].left, assignment[var].left_open, val, false)
            end
        end
        RectGrt(var, val) => begin
            if val >= assignment[var].left
                assignment[var] = Interval(val, true, assignment[var].right, assignment[var].right_open)
            end
        end
        RectGrtEq(var, val) => begin
            if val > assignment[var].left
                assignment[var] = Interval(val, false, assignment[var].right, assignment[var].right_open)
            end
        end
        RectEq(var, val) => begin
            if val > assignment[var].left
                assignment[var] = Interval(val, false, val, false)
            end
        end
        RectAnd(left, right) => _constraint_to_assignment(right, _constraint_to_assignment(left, assignment))
    end
    assignment
end

