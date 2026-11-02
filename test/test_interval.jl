module TestInterval

using Test

include("../src/model_checker/model_checker.jl")
using .ModelChecker

@testset "Interval Tests" begin
    @testset "Construction" begin
        # infinite bounds are always open
        @test Interval(-Inf, false, Inf, false) == full_interval()
        @test Interval(-Inf, false, 1, false).left_open
        @test Interval(0, false, Inf, false).right_open
        @test !Interval(0, false, 1, false).left_open
        @test is_empty(Interval(Inf, false, Inf, false))
        @test is_empty(Interval(-Inf, false, -Inf, false))
        @test_throws ArgumentError Interval(NaN, false, 1, false)
        @test_throws ArgumentError Interval(0, false, 0 * Inf, false)
    end

    @testset "Membership" begin
        @test in_interval(0, Interval(0, false, 1, true))
        @test !in_interval(1, Interval(0, false, 1, true))
        @test in_interval(0.5, Interval(0, true, 1, true))
        @test !in_interval(0, Interval(0, true, 1, true))
        @test !in_interval(1, Interval(1, false, 1, true))
        @test !in_interval(1, Interval(1, true, 1, false))
        @test in_interval(0, zero_interval())
        @test !in_interval(5, zero_interval())
        @test !in_interval(0, empty_interval())
        @test in_interval(1e300, Interval(0, false, Inf, true))
        @test in_interval(-1e300, full_interval())
        @test !in_interval(Inf, full_interval())
        @test !in_interval(-Inf, full_interval())
        @test !in_interval(Inf, Interval(0, false, Inf, false))
        @test !in_interval(NaN, full_interval())
    end

    @testset "Emptiness" begin
        @test is_empty(empty_interval())
        @test !is_empty(zero_interval())
        @test !is_empty(full_interval())
        @test is_empty(Interval(2, false, 1, false))
        @test is_empty(Interval(1, false, 1, true))
        @test !is_empty(Interval(-Inf, true, -1e300, false))
    end

    @testset "Equality and hashing" begin
        @test Interval(0, false, 1, false) == Interval(0, false, 1, false)
        @test Interval(0, false, 1, false) != Interval(0, true, 1, false)
        @test Interval(0, false, 1, false) != Interval(0, false, 1, true)
        @test Interval(0, false, 1, false) != Interval(0, false, 2, false)
        # bounds are compared up to 4 decimals
        @test Interval(1.00001, false, 2, false) == Interval(1.0, false, 2, false)
        @test hash(Interval(1.00001, false, 2, false)) == hash(Interval(1.0, false, 2, false))
        @test Interval(-0.0, false, 1, false) == Interval(0.0, false, 1, false)
        @test hash(Interval(-0.0, false, 1, false)) == hash(Interval(0.0, false, 1, false))
        # all empty intervals are equal
        @test Interval(2, false, 1, false) == empty_interval()
        @test Interval(0.00001, true, 0.00002, true) == empty_interval()
        @test hash(Interval(2, false, 1, false)) == hash(empty_interval())
        @test length(Set([empty_interval(), Interval(3, true, 3, true), Interval(5, false, 1, false)])) == 1
    end

    @testset "Intersection" begin
        @test intersection(Interval(0, false, 5, false), Interval(-Inf, true, 3, true)) == Interval(0, false, 3, true)
        @test intersection(Interval(0, false, 5, false), Interval(0, true, 5, false)) == Interval(0, true, 5, false)
        @test intersection(Interval(0, false, 5, true), Interval(0, false, 5, false)) == Interval(0, false, 5, true)
        @test intersection(Interval(0, false, 1, false), Interval(1, false, 2, false)) == Interval(1, false, 1, false)
        @test is_empty(intersection(Interval(0, false, 1, false), Interval(1, true, 2, false)))
        @test is_empty(intersection(Interval(0, false, 1, false), Interval(2, false, 3, false)))
        @test intersection(full_interval(), Interval(-Inf, true, Inf, true)) == full_interval()
        @test intersection(Interval(-Inf, true, 0, false), Interval(0, false, Inf, true)) == zero_interval()
        @test intersection(Interval[]) == full_interval()
        @test intersection([
            Interval(0, false, 10, false),
            Interval(2, true, Inf, true),
            Interval(-Inf, true, 7, false)
        ]) == Interval(2, true, 7, false)
    end

    @testset "String conversion" begin
        @test interval_to_string(Interval(-Inf, false, 2, false)) == "(-Inf, 2.0]"
        @test interval_to_string(Interval(0, false, Inf, true)) == "[0.0, Inf)"
        @test interval_to_string(Interval(0.5, true, 1, false)) == "(0.5, 1.0]"
    end

    @testset "Monotonicity" begin
        @test monoton_interval(Interval(1, false, 2, false)) == positive
        @test monoton_interval(Interval(0, true, Inf, true)) == positive
        @test monoton_interval(Interval(-2, false, -1, false)) == negative
        @test monoton_interval(Interval(-Inf, true, 0, false)) == negative
        @test monoton_interval(zero_interval()) == negative
        @test monoton_interval(Interval(-1, false, 1, false)) == not_monoton
        @test monoton_interval(full_interval()) == not_monoton
    end
end

end
