include("aliases.jl")

struct Interval
    left::Real
    left_open::Bool
    right::Real
    right_open::Bool
end

# redefine comparison
Base.:(==)(x::Interval, y::Interval) = (
    round5(x.left) == round5(y.left) && round5(x.right) == round5(y.right) &&
    x.left_open == y.left_open && x.right_open == y.right_open
)

function str(interval::Interval)::String
    res = if interval.left_open "(" else "[" end
    res *= "$(interval.left), $(interval.right)"
    res *= if interval.right_open ")" else "]" end
    res
end

function in_interval(num::Real, interval::Interval)::Bool
    if num == interval.left 
        ! left_open
    elseif num == interval.right
        ! right_open
    else
        left < num < right
    end
end

function is_empty(interval::Interval)::Bool
    interval.left > interval.right || (interval.left == interval.right && (interval.left_open || interval.right_open))
end

function empty_interval()::Interval
    return Interval(0, true, 0, true)
end

function full_interval()::Interval
    return Interval(-Inf, true, Inf, true)
end

function zero_interval()::Interval
    return Interval(0, false, 0, false)
end

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
        right = interval_1.left
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

function intersection(intervals::Vector{Interval})::Interval
    intersection_interval = full_interval()
    for interval in intervals
        intersection_interval = intersection(intersection_interval, interval)
    end
    intersection_interval
end




struct MonotonError <: Exception
    msg::AbstractString
end

@enum Monoton begin
    positive
    negative
    not_monoton
end

function monoton_interval(interval::Interval)::Monoton
    if interval.left <= 0 && interval.right <= 0
        return negative
    elseif interval.left >= 0 && interval.right >= 0
        return positive
    else
        return not_monoton
    end
end