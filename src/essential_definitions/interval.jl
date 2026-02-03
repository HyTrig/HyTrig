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