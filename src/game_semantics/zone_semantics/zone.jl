include("../../game_syntax/mhg/edge.jl")

struct Zone
    location::Location
    assignment::IntervalAssignment
end

function time_to_invariant(zone::Zone, max_location_assignment::IntervalAssignment)::Float64
    times = Dict{Variable, Float64}()
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


function zone_shift(zone::Zone, edge::Edge)::Pair(Interval, Zone)
    target_invariant_after_jump = strip_variables(edge.target_location.invariant, keys(edge.jump))
    max_edge_assignment = constraint_to_assignment(RectAnd(RectAnd(zone.location.invariant, edge.guard), target_invariant_after_jump), keys(zone.assignment))

    edge_time_interval = Interval(0,true,0,true) # edge_time_interval(zone (z0), max_edge_assignment)

    after_edge_assignement = IntervalAssignment() # if x in jump -> x => jump, else minimal interval of (x within the time interval & max_edge_assignment)

    shifted_zone = Zone(edge.target_location, after_edge_assignement)
    return (edge_time_interval => shifted_zone)
end




# l0 = Location(:l0, RectAnd(RectLessEq(Var(:x), Const(3)), RectGrt(Var(:y), Const(-3))), IntervalAssignment(:x => Interval(1, false, 2, false), :y => Interval(1, false, 1, false)))

# z0 = Zone(l0, IntervalAssignment(:x => Interval(0, false, 1, false), :y => Interval(0, false, 0, false)))

# z1 = zone_lift(z0)

# l0_inv = constraint_to_assignment(z0.location.invariant, keys(z0.assignment))
# println(l0_inv)
# println(time_to_invariant(z0, l0_inv))
# println(z1.assignment)