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

export Zone, initial_zone, zone_to_string, time_to_invariant, zone_lift, edge_time_interval, zone_shift

# TODO: add type documentation
struct Zone
    location::Location
    assignment::IntervalAssignment
end

# redefine comparison
Base.:(==)(x::Zone, y::Zone) = (
    x.location.name == y.location.name &&
    all(x_interval == y.interval for (var, x_interval) in x.assignment)
)

# TODO: add function documentation
function initial_zone(game::MHG_Game)::Zone
    Zone(game.initial_location, 
                  game.initial_valuation)
end

# TODO: add function documentation
function zone_to_string(zone::Zone)::String
    text = String(zone.location.name)
    for (var, interval) in zone.assignment
        text *= "\n   $var -> $(interval_to_string(interval))"
    end
    text
end

# TODO: add function documentation
function time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Real
    times = Dict{Variable, Real}()
    for (var, max_interval) in max_location_assignment
        flow = zone.location.flow[var]
        if monoton_interval(flow) == positive
            times[var] = if flow.left > 0 ((max_interval.right - zone.assignment[var].left) / flow.left) else Inf end
        else 
            times[var] = if flow.right < 0 ((max_interval.left - zone.assignment[var].right) / flow.right) else Inf end
        end
    end
    minimum(time for (var, time) in times)
end

# TODO: add function documentation
function zone_lift(zone::Zone)::Zone

    max_location_assignment = constraint_to_assignment(zone.location.invariant, keys(zone.assignment))
    max_location_time = time_to_invariant(zone, max_location_assignment)

    new_assignment = IntervalAssignment()

    for (var, original_interval) in zone.assignment
        flow = zone.location.flow[var]
        if monoton_interval(flow) == positive
            if flow.right == 0
                new_assignment[var] = original_interval
            elseif max_location_time == Inf
                new_assignment[var] = Interval(original_interval.left, original_interval.left_open, Inf, true)
            else 
                upper_bound = original_interval.right + flow.right * max_location_time
                if upper_bound >= max_location_assignment[var].right
                    new_assignment[var] = Interval(original_interval.left, original_interval.left_open, max_location_assignment[var].right, flow.right_open || max_location_assignment[var].right_open)
                else
                    new_assignment[var] = Interval(original_interval.left, original_interval.left_open, upper_bound, flow.right_open || original_interval.right_open)
                end
            end
        else
            if flow.left == 0
                new_assignment[var] = original_interval
            elseif max_location_time == Inf
                new_assignment[var] = Interval(-Inf, true, original_interval.right, original_interval.right_open)
            else 
                lower_bound = original_interval.left - flow.left * max_location_time
                if lower_bound <= max_location_assignment[var].left
                    new_assignment[var] = Interval(max_location_assignment[var].left, flow.left_open || max_location_assignment[var].left_open, original_interval.right, original_interval.right_open)
                else
                    new_assignment[var] = Interval(lower_bound, flow.left_open || original_interval.left_open, original_interval.right, original_interval.right_open)
                end
            end
        end
    end
    return Zone(zone.location, new_assignment)
end
# TODO: add function documentation

function edge_time_interval(zone::Zone, edge::MHG_Edge)::Pair{Interval, IntervalAssignment}
    target_invariant_after_jump = strip_variables(edge.target_location.invariant, keys(edge.jump))
    max_edge_assignment = constraint_to_assignment(RectAnd(RectAnd(zone.location.invariant, edge.guard), target_invariant_after_jump), keys(zone.assignment))
    times = Interval[]
    for (var, interval) in zone.assignment
        flow = zone.location.flow[var] 
        if flow.right > 0
            minimum_time =  max(0, (max_edge_assignment[var].left - interval.right) / flow.right) 
        elseif flow.left < 0
            minimum_time = max(0, (max_edge_assignment[var].right - interval.left) / flow.left)
        else    
            if is_empty(intersection(max_edge_assignment[var], interval)) 
                minimum_time =  Inf
            else 
                minimum_time = 0
            end 
        end
        if flow.left > 0
            maximum_time =  max(0, (max_edge_assignment[var].right - interval.left) / flow.left) 
        elseif flow.right < 0
            maximum_time = max(0, (max_edge_assignment[var].left - interval.right) / flow.right)
        else    
            if is_empty(intersection(max_edge_assignment[var], interval)) 
                maximum_time =  Inf
            else 
                maximum_time = 0
            end 
        end
        push!(times, Interval(minimum_time, true, maximum_time, true))
    end
    edge_time = intersection(times)
    edge_assignment = IntervalAssignment()
    for (var, interval) in zone.assignment
        var_interval = Interval(interval.left + zone.location.flow[var].left * edge_time.left, true, interval.right + zone.location.flow[var].right * edge_time.right, true)
        edge_assignment[var] = intersection(var_interval, max_edge_assignment[var])
    end
    return (edge_time => edge_assignment)
end

# TODO: add function documentation
function zone_shift(zone::Zone, edge::Edge)::Pair{Interval, Zone}

    edge_time, edge_assignment = edge_time_interval(zone, edge)

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
