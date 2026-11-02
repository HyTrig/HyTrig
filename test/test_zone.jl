module TestZone

using Test

include("../src/model_checker/model_checker.jl")
using .ModelChecker

# shorthands for closed, open and point intervals
closed(left, right) = Interval(left, false, right, false)
open_interval(left, right) = Interval(left, true, right, true)
point(value) = closed(value, value)

location(name, invariant, flow...) = MHG_Location(name, invariant, IntervalAssignment(flow...))
edge(start, target, guard, jump...) = MHG_Edge(:e, start, target, guard, :a => :act, IntervalAssignment(jump...))

@testset "Zone Tests" begin
    @testset "Equality and hashing" begin
        l = location(:l, RectTrue(), :x => point(0), :y => point(0))
        z = Zone(l, IntervalAssignment(:x => closed(0, 1), :y => point(2)))
        @test z == Zone(l, IntervalAssignment(:x => closed(0, 1), :y => point(2)))
        @test z == Zone(l, IntervalAssignment(:y => point(2), :x => closed(0, 1)))
        @test hash(z) == hash(Zone(l, IntervalAssignment(:y => point(2), :x => closed(0, 1))))
        @test z != Zone(l, IntervalAssignment(:x => closed(0, 1), :y => point(3)))
        @test z != Zone(l, IntervalAssignment(:x => closed(0, 1)))
        @test z != Zone(location(:m, RectTrue(), :x => point(0), :y => point(0)), z.assignment)
        @test length(Set([z, Zone(l, IntervalAssignment(:x => closed(0, 1), :y => point(2)))])) == 1
    end

    @testset "Time to invariant" begin
        zone(flow, interval) = Zone(location(:l, RectTrue(), :x => flow), IntervalAssignment(:x => interval))
        upper_5 = IntervalAssignment(:x => Interval(-Inf, true, 5, false))
        lower_0 = IntervalAssignment(:x => Interval(0, false, Inf, true))
        @test time_to_invariant(zone(closed(1, 2), closed(0, 1)), upper_5) == 5
        @test time_to_invariant(zone(closed(-2, -1), closed(3, 4)), lower_0) == 4
        @test time_to_invariant(zone(closed(-1, 1), point(0)), upper_5) == Inf
        @test time_to_invariant(zone(closed(0, 2), point(0)), upper_5) == Inf
        @test time_to_invariant(zone(closed(1, 2), point(0)), IntervalAssignment(:x => full_interval())) == Inf
        @test time_to_invariant(zone(closed(1, 2), point(0)), IntervalAssignment()) == Inf
    end

    @testset "Zone lift" begin
        # y grows with rate 1 up to 1, so time can pass for 1 time unit
        lift(flow, interval; invariant=RectLessEq(:y, 1.0)) = zone_lift(Zone(
            location(:l, invariant, :x => flow, :y => point(1)),
            IntervalAssignment(:x => interval, :y => point(0))
        )).assignment

        @test lift(closed(1, 3), point(0)) == IntervalAssignment(:x => closed(0, 3), :y => closed(0, 1))
        @test lift(Interval(1, false, 3, true), point(0))[:x] == Interval(0, false, 3, true)
        @test lift(closed(1, 3), Interval(0, false, 0.5, true))[:x] == Interval(0, false, 3.5, true)
        # positive flow, cut by the invariant
        @test lift(closed(1, 3), point(0); invariant=RectAnd(RectLessEq(:y, 1.0), RectLess(:x, 2.0)))[:x] == Interval(0, false, 2, true)
        # negative flow moves the lower bound down
        @test lift(closed(-2, -1), closed(3, 4))[:x] == closed(1, 4)
        @test lift(closed(-2, -1), closed(3, 4); invariant=RectAnd(RectLessEq(:y, 1.0), RectGrtEq(:x, 2.0)))[:x] == closed(2, 4)
        # non-monotonic flow widens both bounds
        @test lift(closed(-1, 2), point(0))[:x] == closed(-1, 2)
        @test lift(closed(-1, 2), point(0); invariant=RectAnd(RectLessEq(:y, 1.0), RectGrtEq(:x, -0.5)))[:x] == closed(-0.5, 2)
        # zero flow keeps the interval
        @test lift(point(0), closed(1, 2))[:x] == closed(1, 2)
        # time can pass forever: positive flow is still cut by the invariant
        @test lift(closed(0, 1), point(0); invariant=RectLessEq(:x, 5.0)) == IntervalAssignment(:x => closed(0, 5), :y => Interval(0, false, Inf, true))
        @test lift(closed(-1, 1), point(0); invariant=RectTrue())[:x] == full_interval()
        @test lift(closed(-1, 0), point(0); invariant=RectTrue())[:x] == Interval(-Inf, true, 0, false)
        @test lift(point(0), point(3); invariant=RectTrue())[:x] == point(3)
    end

    @testset "Edge time interval" begin
        l = location(:l, RectLessEq(:x, 10.0), :x => point(1), :y => point(0))
        z = Zone(l, IntervalAssignment(:x => point(0), :y => point(1)))

        # x reaches [2, 10] during (2, 10); y does not move
        time, assignment = edge_time_interval(z, edge(l, l, RectGrtEq(:x, 2.0)))
        @test time == open_interval(2, 10)
        @test assignment == IntervalAssignment(:x => open_interval(2, 10), :y => point(1))

        # no upper bound on the time
        u = location(:u, RectTrue(), :x => point(1), :y => point(0))
        time, assignment = edge_time_interval(Zone(u, z.assignment), edge(u, u, RectGrtEq(:x, 2.0)))
        @test time == open_interval(2, Inf)
        @test assignment == IntervalAssignment(:x => open_interval(2, Inf), :y => point(1))

        # the target invariant applies unless the jump resets the variable
        m = location(:m, RectLessEq(:x, 3.0), :x => point(0), :y => point(0))
        @test first(edge_time_interval(z, edge(l, m, RectGrtEq(:x, 2.0)))) == open_interval(2, 3)
        @test first(edge_time_interval(z, edge(l, m, RectGrtEq(:x, 2.0), :x => point(0)))) == open_interval(2, 10)

        # unreachable guard
        time, assignment = edge_time_interval(z, edge(l, l, RectLessEq(:x, -1.0)))
        @test is_empty(time)
        @test all(is_empty, values(assignment))

        # negative flow: x falls from 10 into [0, 4] during (6, 10)
        n = location(:n, RectGrtEq(:x, 0.0), :x => point(-1))
        time, assignment = edge_time_interval(Zone(n, IntervalAssignment(:x => point(10))), edge(n, n, RectLessEq(:x, 4.0)))
        @test time == open_interval(6, 10)
        @test assignment[:x] == open_interval(0, 4)

        # non-monotonic flow: x can fall from 5 to 2 after 3 time units at the earliest
        k = location(:k, RectTrue(), :x => closed(-1, 1))
        time, assignment = edge_time_interval(Zone(k, IntervalAssignment(:x => point(5))), edge(k, k, RectLessEq(:x, 2.0)))
        @test time == open_interval(3, Inf)
        @test assignment[:x] == Interval(-Inf, true, 2, false)

        # a zone already in the guard with zero flow can take the edge at any time
        s = location(:s, RectTrue(), :x => point(0))
        @test first(edge_time_interval(Zone(s, IntervalAssignment(:x => point(1))), edge(s, s, RectLessEq(:x, 2.0)))) == open_interval(0, Inf)
    end

    @testset "Zone shift" begin
        l = location(:l, RectLessEq(:x, 10.0), :x => point(1), :y => point(0))
        m = location(:m, RectTrue(), :x => point(0), :y => point(0))
        z = Zone(l, IntervalAssignment(:x => point(0), :y => point(1)))
        time, shifted = zone_shift(z, edge(l, m, RectGrtEq(:x, 2.0), :x => closed(-1, 1)))
        @test time == open_interval(2, 10)
        @test shifted == Zone(m, IntervalAssignment(:x => closed(-1, 1), :y => point(1)))
    end

    @testset "Zone to string" begin
        l = location(:l, RectTrue(), :x => point(0))
        @test zone_to_string(Zone(l, IntervalAssignment(:x => Interval(-Inf, true, 2, false)))) == "l\n   x -> (-Inf, 2.0]"
    end
end

end
