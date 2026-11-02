"""
    zone.jl

Zones of multi-hybrid games and the operations to explore them.

A zone is a location together with an interval for every variable. The flow of a
location gives, for every variable, an interval of rates: `x' ∈ [a, b]`. Starting
from the interval `[l, r]`, a variable can therefore take the values
`[l + a * t, r + b * t]` after `t` time units.

# Types:
- `Zone`: A location with an interval assignment of all variables.

# Functions:
- `initial_zone(game::MHG_Game)::Zone`: The zone of the initial location and valuation.
- `zone_to_string(zone::Zone)::String`: Pretty-print a zone.
- `time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Real`: Time until every point of the zone has left the invariant.
- `zone_lift(zone::Zone)::Zone`: Let time pass in the zone's location.
- `edge_time_interval(zone::Zone, edge::MHG_Edge)::Pair{Interval, IntervalAssignment}`: Times and values at which an edge can be taken.
- `zone_shift(zone::Zone, edge::Edge)::Pair{Interval, Zone}`: Take an edge from a zone.

# Authors:
- Author 1
- Author 2
"""

export Zone, initial_zone, zone_to_string, time_to_invariant, zone_lift, edge_time_interval, zone_shift

"""
    Zone

A `location` together with an interval for every variable in `assignment`.
"""
struct Zone
    location::Location
    assignment::IntervalAssignment
end

# redefine comparison: same location name and equal intervals for the same variables
Base.:(==)(x::Zone, y::Zone) = x.location.name == y.location.name && x.assignment == y.assignment
Base.hash(zone::Zone, h::UInt) = hash(zone.assignment, hash(zone.location.name, hash(Zone, h)))

"""
    initial_zone(game::MHG_Game)::Zone

Return the zone of the initial location with the initial valuation of `game`.
"""
function initial_zone(game::MHG_Game)::Zone
    Zone(game.initial_location,
                  game.initial_valuation)
end

"""
    zone_to_string(zone::Zone)::String

Format `zone` as its location name followed by one line per variable interval.
"""
function zone_to_string(zone::Zone)::String
    text = String(zone.location.name)
    for (var, interval) in zone.assignment
        text *= "\n   $var -> $(interval_to_string(interval))"
    end
    text
end

"""
    time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Real

Return the time after which every point of `zone` has left the invariant box
`max_location_assignment`, or `Inf` if some point can stay forever. A variable
whose rates include `0` can stay where it is, so it never forces time to end.
"""
function time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Real
    time = Inf
    for (var, max_interval) in max_location_assignment
        flow = zone.location.flow[var]
        if flow.left > 0
            # the lowest point, growing at the lowest rate, passes the upper bound
            time = min(time, (max_interval.right - zone.assignment[var].left) / flow.left)
        elseif flow.right < 0
            # the highest point, falling at the highest rate, passes the lower bound
            time = min(time, (max_interval.left - zone.assignment[var].right) / flow.right)
        end
    end
    return time
end

"""
    zone_lift(zone::Zone)::Zone

Let up to `time_to_invariant` time units pass in the zone's location. Every
variable interval is widened by its flow, downwards by negative rates and upwards
by positive rates, and then cut to the location invariant.
"""
function zone_lift(zone::Zone)::Zone

    max_location_assignment = constraint_to_assignment(zone.location.invariant, collect(keys(zone.assignment)))
    max_location_time = time_to_invariant(zone, max_location_assignment)

    new_assignment = IntervalAssignment()

    for (var, original_interval) in zone.assignment
        flow = zone.location.flow[var]
        # waiting for 0 time units is allowed, so a bound only moves if its rate points outwards;
        # the checks also avoid 0 * Inf when the location can be stayed in forever
        if flow.left < 0 && max_location_time > 0
            left = original_interval.left + flow.left * max_location_time
            left_open = original_interval.left_open || flow.left_open
        else
            left = original_interval.left
            left_open = original_interval.left_open
        end
        if flow.right > 0 && max_location_time > 0
            right = original_interval.right + flow.right * max_location_time
            right_open = original_interval.right_open || flow.right_open
        else
            right = original_interval.right
            right_open = original_interval.right_open
        end
        new_assignment[var] = intersection(Interval(left, left_open, right, right_open), max_location_assignment[var])
    end
    return Zone(zone.location, new_assignment)
end

# Times `t` with `rate * t <= bound`, as an open interval.
function _times_below(rate::Float64, bound::Float64)::Interval
    if bound == Inf
        return full_interval()
    elseif rate > 0
        return Interval(-Inf, true, bound / rate, true)
    elseif rate < 0
        return Interval(bound / rate, true, Inf, true)
    elseif bound >= 0
        return full_interval()
    else
        return empty_interval()
    end
end

# Bound of the values reached from `bound` with `rate` during the times `times`:
# the earliest time if the rate points inwards, the latest one if it points outwards.
function _reached_bound(bound::Float64, rate::Float64, times::Interval, outwards::Bool)::Float64
    if rate == 0
        return bound
    end
    time = (rate > 0) == outwards ? times.right : times.left
    return bound + rate * time
end

"""
    edge_time_interval(zone::Zone, edge::MHG_Edge)::Pair{Interval, IntervalAssignment}

Return the times at which `edge` can be taken from `zone`, together with the
variable intervals at those times. A time `t > 0` is possible if for every
variable the values reachable at `t` meet the invariant, the guard and the target
invariant of the variables not reset by the jump. The returned times are open, and
the variable intervals are empty if the edge can never be taken.
"""
function edge_time_interval(zone::Zone, edge::MHG_Edge)::Pair{Interval, IntervalAssignment}
    target_invariant_after_jump = strip_variables(edge.target_location.invariant, collect(keys(edge.jump)))
    max_edge_assignment = constraint_to_assignment(RectAnd(RectAnd(zone.location.invariant, edge.guard), target_invariant_after_jump), collect(keys(zone.assignment)))
    times = Interval[Interval(0, true, Inf, true)]
    for (var, interval) in zone.assignment
        flow = zone.location.flow[var]
        target = max_edge_assignment[var]
        if is_empty(interval) || is_empty(target) || is_empty(flow)
            push!(times, empty_interval())
            continue
        end
        # reachable at time t: [interval.left + flow.left * t, interval.right + flow.right * t];
        # it meets the target iff its lower end is below target.right and its upper end above target.left
        push!(times, _times_below(flow.left, target.right - interval.left))
        push!(times, _times_below(-flow.right, interval.right - target.left))
    end
    edge_time = intersection(times)
    edge_assignment = IntervalAssignment()
    for (var, interval) in zone.assignment
        if is_empty(edge_time)
            edge_assignment[var] = empty_interval()
            continue
        end
        flow = zone.location.flow[var]
        var_interval = Interval(
            _reached_bound(interval.left, flow.left, edge_time, false), interval.left_open || flow.left != 0,
            _reached_bound(interval.right, flow.right, edge_time, true), interval.right_open || flow.right != 0
        )
        edge_assignment[var] = intersection(var_interval, max_edge_assignment[var])
    end
    return edge_time, edge_assignment
end

"""
    zone_shift(zone::Zone, edge::Edge)::Pair{Interval, Zone}

Take `edge` from `zone`. Return the times at which the edge can be taken and the
zone in the target location, with the variables of the jump set to their new
intervals.
"""
function zone_shift(zone::Zone, edge::Edge)::Pair{Interval, Zone}

    edge_time, edge_assignment = edge_time_interval(zone, edge, variables)

    after_edge_assignment = IntervalAssignment()

    for (var, interval) in edge_assignment
        if var in keys(edge.jump)
            after_edge_assignment[var] = edge.jump[var]
        else
            after_edge_assignment[var] = interval
        end
    end

    shifted_zone = Zone(edge.target_location, after_edge_assignment)
    return (edge_time => shifted_zone)
end
