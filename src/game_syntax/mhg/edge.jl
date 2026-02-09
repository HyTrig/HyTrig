include("location.jl")

struct MHG_Edge <: Edge
    name::Symbol
    start_location::MHG_Location
    target_location::MHG_Location
    guard::RectConstr
    decision::Decision
    jump::IntervalAssignment
end
