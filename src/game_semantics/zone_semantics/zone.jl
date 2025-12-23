include("../../game_syntax/mhg/location.jl")

struct Zone
    location::Location
    interval_assignment::IntervalAssignment
end

function time_to_interval(zone, assignment)::Float64
    minimum()
end

function zone_lift(zone::Zone)::Zone
    new_interval_assignment = IntervalAssignment()

    invariant_assignment = trim_rect_constr(zone.location.invariant, zone.interval_assignment)
    interval_time = time_to_interval(zone, invariant_assignment)
    for (var, interval) in zone.interval_assignment
        if monoton_interval(zone.location.flow[var]) == positive
            new_interval_assignment[var] = Interval(zone.interval.left, zone.interval.left_open, Inf, true)
        elseif monoton_interval(zone.location.flow[var]) == negative
            new_interval_assignment[var] = Interval(-Inf, true, Inf, true)
        else 
            throw(MonotonError("The given game is not a monoton hybrid game. See interval $(str(interval)) at the flow of location $(zone.location.name)"))
        end
    end
    return Zone(zone.location, new_interval_assignment)
end