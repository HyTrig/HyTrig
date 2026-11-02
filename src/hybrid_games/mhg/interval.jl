"""
    interval.jl

Intervals of real numbers, used by multi-hybrid games for flows, jumps and zones.

An `Interval` describes a (possibly empty or unbounded) set of real numbers with an
open or closed bound on each side. The bounds `-Inf` and `Inf` stand for unbounded
sides. Since infinities are not real numbers, an infinite bound is always open:
the constructor turns `[-Inf, x]` into `(-Inf, x]`, and so on.

# Types:
- `Interval`: A real interval with open or closed bounds.
- `MonotonError`: Exception for intervals that are expected to be monotonic.
- `Monoton`: Sign of an interval: `positive`, `negative` or `not_monoton`.

# Functions:
- `interval_to_string(interval::Interval)::String`: Format an interval as e.g. `(-Inf, 2.0]`.
- `in_interval(num::Real, interval::Interval)::Bool`: Check whether a number lies in an interval.
- `is_empty(interval::Interval)::Bool`: Check whether an interval contains no real number.
- `empty_interval()::Interval`: The empty interval `(0, 0)`.
- `full_interval()::Interval`: The interval `(-Inf, Inf)` of all real numbers.
- `zero_interval()::Interval`: The point interval `[0, 0]`.
- `intersection(interval_1::Interval, interval_2::Interval)::Interval`: Intersect two intervals.
- `intersection(intervals::Vector{Interval})::Interval`: Intersect a list of intervals.
- `monoton_interval(interval::Interval)::Monoton`: Determine the sign of an interval.

# Authors:
- Author 1
- Author 2
"""

export Interval, interval_to_string, in_interval, is_empty, empty_interval, full_interval, zero_interval, intersection
export MonotonError, Monoton, positive, negative, not_monoton, monoton_interval
export IntervalAssignment, constraint_to_assignment

"""
    Interval

An interval of real numbers from `left` to `right`. Each bound is either open
(excluded) or closed (included). Bounds may be `-Inf` or `Inf` for unbounded sides.

    Interval(left::Real, left_open::Bool, right::Real, right_open::Bool)::Interval

Create the interval from `left` to `right`. Infinite bounds are always made open,
and `NaN` bounds throw an `ArgumentError`. If `left > right`, or the bounds are
equal and one of them is open, the interval is empty (see `is_empty`).

# Examples
```julia-repl
julia> interval_to_string(Interval(-Inf, false, 2, false))
"(-Inf, 2.0]"
```
"""
struct Interval
    left::Float64
    left_open::Bool
    right::Float64
    right_open::Bool

    function Interval(left::Real, left_open::Bool, right::Real, right_open::Bool)::Interval
        if isnan(left) || isnan(right)
            throw(ArgumentError("interval bounds must not be NaN, got $left and $right"))
        end
        new(left, left_open || isinf(left), right, right_open || isinf(right))
    end
end

# Canonical form used for comparison and hashing: bounds rounded to 4 decimals,
# and all empty intervals mapped to the same value.
function _interval_key(interval::Interval)
    rounded = Interval(round4(interval.left), interval.left_open, round4(interval.right), interval.right_open)
    if is_empty(rounded)
        return :empty
    end
    # adding 0.0 turns -0.0 into 0.0, which hashes differently otherwise
    return (rounded.left + 0.0, rounded.left_open, rounded.right + 0.0, rounded.right_open)
end

# redefine comparison: equal up to 4 decimals, and all empty intervals are equal
Base.:(==)(x::Interval, y::Interval) = _interval_key(x) == _interval_key(y)
Base.hash(interval::Interval, h::UInt) = hash(_interval_key(interval), hash(Interval, h))

"""
    interval_to_string(interval::Interval)::String

Format `interval` with parentheses for open and brackets for closed bounds.

# Examples
```julia-repl
julia> interval_to_string(Interval(0, false, Inf, true))
"[0.0, Inf)"
```
"""
function interval_to_string(interval::Interval)::String
    left_bracket = interval.left_open ? "(" : "["
    right_bracket = interval.right_open ? ")" : "]"
    return "$left_bracket$(interval.left), $(interval.right)$right_bracket"
end

"""
    in_interval(num::Real, interval::Interval)::Bool

Check whether `num` lies in `interval`. Infinities and `NaN` are never contained,
since infinite bounds are always open.
"""
function in_interval(num::Real, interval::Interval)::Bool
    above_left = interval.left_open ? interval.left < num : interval.left <= num
    below_right = interval.right_open ? num < interval.right : num <= interval.right
    return above_left && below_right
end

"""
    is_empty(interval::Interval)::Bool

Check whether `interval` contains no real number, i.e. `left > right`, or
`left == right` and one of the bounds is open.
"""
function is_empty(interval::Interval)::Bool
    return interval.left > interval.right ||
        (interval.left == interval.right && (interval.left_open || interval.right_open))
end

"""
    empty_interval()::Interval

Return the empty interval `(0, 0)`.
"""
function empty_interval()::Interval
    return Interval(0, true, 0, true)
end

"""
    full_interval()::Interval

Return the interval `(-Inf, Inf)` of all real numbers.
"""
function full_interval()::Interval
    return Interval(-Inf, true, Inf, true)
end

"""
    zero_interval()::Interval

Return the point interval `[0, 0]`.
"""
function zero_interval()::Interval
    return Interval(0, false, 0, false)
end

"""
    intersection(interval_1::Interval, interval_2::Interval)::Interval

Intersect two intervals. The result takes the larger left and the smaller right
bound. If both intervals share a bound, it is open when it is open in either one.
The result may be empty.
"""
function intersection(interval_1::Interval, interval_2::Interval)::Interval
    left, left_open = if interval_1.left == interval_2.left
        interval_1.left, interval_1.left_open || interval_2.left_open
    elseif interval_1.left > interval_2.left
        interval_1.left, interval_1.left_open
    else
        interval_2.left, interval_2.left_open
    end
    right, right_open = if interval_1.right == interval_2.right
        interval_1.right, interval_1.right_open || interval_2.right_open
    elseif interval_1.right < interval_2.right
        interval_1.right, interval_1.right_open
    else
        interval_2.right, interval_2.right_open
    end
    return Interval(left, left_open, right, right_open)
end

"""
    intersection(intervals::Vector{Interval})::Interval

Intersect all `intervals`. An empty vector gives `full_interval()`.
"""
function intersection(intervals::Vector{Interval})::Interval
    return reduce(intersection, intervals; init=full_interval())
end

# TODO: rename to monotonic
"""
    MonotonError <: Exception

Error for an interval that is expected to be monotonic, i.e. not change sign.
"""
struct MonotonError <: Exception
    msg::AbstractString
end

"""
    Monoton

Sign of an interval, as computed by `monoton_interval`.

- `positive`: All values are `>= 0`.
- `negative`: All values are `<= 0`.
- `not_monoton`: The interval contains both negative and positive values.
"""
@enum Monoton begin
    positive
    negative
    not_monoton
end

"""
    monoton_interval(interval::Interval)::Monoton

Determine the sign of `interval` from its bounds, regardless of whether they are
open. The point interval `[0, 0]` counts as `negative`.

# Examples
```julia-repl
julia> monoton_interval(Interval(0, true, Inf, true))
positive::Monoton = 0
```
"""
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

