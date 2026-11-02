module TestParseMhgGame

using Test

include("../src/hgtmc.jl")
using .HgtMc

@testset "MHG Game Parser Tests" begin
    @testset "Interval parsing" begin
        interval = parse_interval("[0, 1)")
        @test (interval.left, interval.left_open, interval.right, interval.right_open) == (0.0, false, 1.0, true)
        interval = parse_interval("(0.5, 2]")
        @test (interval.left, interval.left_open, interval.right, interval.right_open) == (0.5, true, 2.0, false)
        @test parse_interval("[1, 1]") == Interval(1, false, 1, false)
        @test parse_interval("  ( 1 , 2.5e1 ]  ") == Interval(1, true, 25, false)
        # infinite bounds are open, even if written with brackets
        @test parse_interval("(-Inf, Inf)") == full_interval()
        @test parse_interval("[-Inf, Inf]") == full_interval()
        @test parse_interval("[0, Inf]") == Interval(0, false, Inf, true)
        # round trip
        for interval in [Interval(-1, true, 2, false), Interval(-Inf, true, 0, false), zero_interval(), Interval(0.25, true, 0.75, true)]
            @test parse_interval(interval_to_string(interval)) == interval
        end
        # malformed input
        for text in ["", "[]", "[1]", "0, 1", "[0; 1]", "[a, 1]", "[0, 1, 2]", "{0, 1}", "[0, 1"]
            @test_throws ArgumentError parse_interval(text)
        end
        @test_throws ArgumentError parse_interval("[NaN, 1]")
    end
end

end
