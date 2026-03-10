module TestParser

using Test

include("../src/model_checker/model_checker.jl")
using .ModelChecker

include("../src/parser/parser.jl")
using .Parser
using .Parser: parse

@testset "Parser Tests" begin
    expr1 = parse("x + y * z", Bindings([], [], ["x", "y", "z"]), expression)
    @test expr1 == Add(Var(:x), Mul(Var(:y), Var(:z)))
    @test_throws ParseError("Cannot parse empty expressions or strategies.") parse("", Bindings([], [], []), expression)

    constr1 = parse("x + y * z > 0", Bindings([], [], ["x", "y", "z"]), constraint)
    @test constr1 == Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0))
    constr2 = parse("x + y * z > 0 && z > 0", Bindings([], [], ["x", "y", "z"]), constraint)
    @test constr2 == And(
        Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0)),
        Greater(Var(:z), Const(0.0))
    )
    constr3 = parse("", Bindings([], [], []), constraint)
    @test constr3 == Truth(true)

    state1 = parse("x + y * z > 0", Bindings([], [], ["x", "y", "z"]), state)
    @test state1 == State_Constraint(Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0)))
    state2 = parse("x + y * z > 0 && z > 0", Bindings([], [], ["x", "y", "z"]), state)
    @test state2 == State_Constraint(
        And(
            Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0)),
            Greater(Var(:z), Const(0.0))
        )
    )
    state3 = parse("x + y * z > 0 || z > 0", Bindings([], [], ["x", "y", "z"]), state)
    @test state3 == State_Constraint(
        Or(
            Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0)),
            Greater(Var(:z), Const(0.0))
        )
    )
    state4 = parse("x + y * z > 0 && loc1", Bindings([], ["loc1"], ["x", "y", "z"]), state)
    @test state4 == State_And(
        State_Constraint(Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0))),
        State_Location(:loc1)
    )
    state5 = parse("true", Bindings([], [], []), state)
    @test state5 == State_Constraint(Truth(true))
    state7 = parse("", Bindings([], [], []), state)
    @test state7 == State_Constraint(Truth(false))

    state6 = parse("deadlock", Bindings([], [], []), strategy)
    @test state6 == Strategy_to_Deadlock()
    strategy1 = parse("true", Bindings([], [], []), strategy)
    @test strategy1 == Strategy_to_State(State_Constraint(Truth(true)))
    strategy2 = parse("<<>> F true", Bindings([], [], []), strategy)
    @test strategy2 == Exist_Eventually([], State_Constraint(Truth(true)))
    strategy3 = parse("<<A>> F true", Bindings(["A"], [], []), strategy)
    @test strategy3 == Exist_Eventually([:A], State_Constraint(Truth(true)))
    strategy4 = parse("<<A, B, C, D>> F x + y * z > 0 && loc1", Bindings(["A", "B", "C", "D"], ["loc1"], ["x", "y", "z"]), strategy)
    @test strategy4 == Exist_Eventually(
        [:A, :B, :C, :D],
        State_And(
            State_Constraint(Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0))), 
            State_Location(:loc1)
        )
    )
    strategy5 = parse("<<A, B, C, D>> F x + y * z > 0 && loc1", Bindings(["A", "B", "C", "D"], ["loc1"], ["x", "y", "z"]), strategy)
    @test strategy5 == Exist_Eventually([:A, :B, :C, :D], 
        State_And(
            State_Constraint(Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0))),                 State_Location(:loc1)
        )
    )
    strategy6 = parse("<<A, B, C, D>> F x + y * z > 0 && loc1", Bindings(["A", "B", "C", "D"], ["loc1"], ["x", "y", "z"]), strategy)
    @test strategy6 == Exist_Eventually([:A, :B, :C, :D], 
        State_And(
            State_Constraint(Greater(Add(Var(:x), Mul(Var(:y), Var(:z))), Const(0.0))), 
            State_Location(:loc1)
        )
    )     
    @test_throws ParseError("Cannot parse empty expressions or strategies.") parse("", Bindings([], [], []), strategy)
end

end
