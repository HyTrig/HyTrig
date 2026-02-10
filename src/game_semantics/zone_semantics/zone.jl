include("../../game_syntax/mhg/game.jl")

struct Zone
    location::Location
    assignment::IntervalAssignment
end

function initial_zone(game::MHG_Game)::Zone
    Zone(game.initial_location, 
                  game.initial_valuation)
end

# redefine comparison
Base.:(==)(x::Zone, y::Zone) = (
    x.location.name == y.location.name &&
    all(x_interval == y.assignment[var].interval for (var, x_interval) in x.assignment)
)

function str(zone::Zone)::String
    text = String(zone.location.name)
    for (var, interval) in zone.assignment
        text *= "\n   $var -> $(str(interval))"
    end
    text
end

function time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Tuple{Real, Bool}
    times = Dict{Variable, Real}()
    for (var, max_interval) in max_location_assignment
        flow = zone.location.flow[var]
        if monoton_interval(flow) == positive
            times[var] = if flow.left > 0.0 ((max_interval.right - zone.assignment[var].left) / flow.left) else Inf end
        else 
            times[var] = if flow.right < 0.0 ((max_interval.left - zone.assignment[var].right) / flow.right) else Inf end
        end
    end
    return minimum(time for (var, time) in times), true
end

function zone_lift(zone::Zone, variables::Container{Variable})::Zone

    max_location_assignment = constraint_to_assignment(zone.location.invariant, variables)
    max_location_time, location_time_open = time_to_invariant(zone, max_location_assignment)

    new_assignment = IntervalAssignment()

    for (var, original_interval) in zone.assignment
        flow = zone.location.flow[var]
        if monoton_interval(flow) == positive
            if flow.right == 0.0
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
            if flow.left == 0.0
                new_assignment[var] = original_interval
            elseif max_location_time == Inf
                new_assignment[var] = Interval(-Inf, true, original_interval.right, original_interval.right_open)
            else 
                lower_bound = original_interval.left + flow.left * max_location_time
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

function edge_time_interval(zone::Zone, edge::MHG_Edge, variables::Container{Variable})::Tuple{Interval, IntervalAssignment}
    target_invariant_after_jump = strip_variables_from_rectconstraint(edge.target_location.invariant, keys(edge.jump))
    max_edge_assignment = constraint_to_assignment(RectAnd(RectAnd(zone.location.invariant, edge.guard), target_invariant_after_jump), variables)
    times = Interval[]
    for (var, interval) in zone.assignment
        flow = zone.location.flow[var] 
        minimum_time = Inf
        if ! is_empty(intersection(max_edge_assignment[var], interval)) 
            minimum_time =  0.0
        elseif flow.right > 0.0
            minimum_time =  max(0, (max_edge_assignment[var].left - interval.right) / flow.right) 
        elseif flow.left < 0.0
            minimum_time = max(0, (max_edge_assignment[var].right - interval.left) / flow.left)
        end

        maximum_time =  Inf
        if flow.left > 0.0
            maximum_time =  max(0, (max_edge_assignment[var].right - interval.left) / flow.left) 
        elseif flow.right < 0.0
            maximum_time = max(0, (max_edge_assignment[var].left - interval.right) / flow.right)
        # else    
        #     if is_empty(intersection(max_edge_assignment[var], interval)) 
        #         maximum_time =  Inf
        #     else 
        #         maximum_time = 0.0
        #     end 
        end
        push!(times, Interval(minimum_time, true, maximum_time, true))
    end
    edge_time = intersection(times)
    edge_assignment = IntervalAssignment()
    for (var, interval) in zone.assignment
        if var in keys(zone.location.flow)
            var_interval = Interval(interval.left + zone.location.flow[var].left * edge_time.left, true, 
                                    interval.right + zone.location.flow[var].right * edge_time.right, true)
            println(var, " initial interval => ", str(var_interval))
            println(var, " flow => ", str(zone.location.flow[var]))
        else
            var_interval = max_edge_assignment[var]
        end
        edge_assignment[var] = intersection(var_interval, max_edge_assignment[var])
    end
    return edge_time, edge_assignment
end

function zone_shift(zone::Zone, edge::Edge, variables::Container{Variable})::Tuple{Interval, Zone}

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
    return edge_time, shifted_zone
end