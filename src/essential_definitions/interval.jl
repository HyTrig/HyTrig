struct Interval
    left::Real
    left_open::Bool
    right::Real
    right_open::Bool

    function Interval(left::Real,
                      left_open::Bool,
                      right::Real,
                      right_open::Bool)
        if left > right
            new(0, true, 0, true)
        else
            new(left, left_open, right, right_open)
        end
    end
end

function str(interval::Interval)::String
    res = if interval.left_open "(" else "[" end
    res *= "$(interval.left), $(interval.right)"
    res *= if interval.right_open ")" else "]" end
    res
end

function within(num::Float64, interval::Interval)::Bool
    if num == interval.left 
        ! left_open
    elseif num == interval.right
        ! right_open
    else
        left < num < right
    end
end


function interval_intersect(interval_1::Interval, interval_2::Interval)::Interval
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