module TestFormulaParser

using Test

include("../src/parser/formula_parser/formula_parser.jl")
using .FormulaParser

@testset "Formula Parser Tests" begin
    # test expressions

    ast::Union{ASTNode, Nothing} = parse_formula("", Bindings([], [], []), expression)
    @test isnothing(ast)

    bindings = Bindings([], [], ["a", "b"])
    ast = parse_formula("a+b", bindings, expression)
    @test ast == ExpressionBinaryOperation("+", VariableNode("a"), VariableNode("b"))
    @test to_string(ast) == "(a)+(b)"
    @test ast == parse_formula("(a+b)", bindings, expression)
    @test ast == parse_formula("((a)+b)", bindings, constraint)
    @test ast == parse_formula("(a+(b))", bindings, state)
    @test ast == parse_formula("((a)+(b))", bindings, strategy)
    @test ast == parse_formula("(a)+(b)", bindings, strategy)
    @test_throws ParseError("Cannot parse tokens 'a', '(', '+', ')', 'b'.") parse_formula("a(+)b", bindings, expression)
    @test_throws ParseError("Cannot parse tokens 'a', '(', ')', '+', 'b'.") parse_formula("a()+b", bindings, expression)
    @test_throws ParseError("Cannot parse tokens '(a)+(b)', ')'.") parse_formula("a+b)", bindings, expression)

    bindings = Bindings([], [], ["a"])
    ast = parse_formula("-a", bindings, expression)
    @test ast == ExpressionUnaryOperation("-", VariableNode("a"))
    @test to_string(ast) == "-(a)"
    @test ast == parse_formula("-(a)", bindings, expression)
    @test ast == parse_formula("(-(a))", bindings, constraint)
    @test_throws ParseError("Cannot parse tokens '(', '-', ')', 'a'.") parse_formula("(-)(a)", bindings, expression)

    bindings = Bindings([], [], ["a", "b"])
    ast = parse_formula("b+(-a)", bindings, expression)
    @test ast == ExpressionBinaryOperation("+", VariableNode("b"), ExpressionUnaryOperation("-", VariableNode("a")))
    @test to_string(ast) == "(b)+(-(a))"
    @test ast == parse_formula("b+ -a", bindings, expression)
    @test ast == parse_formula("(b+(-a))", bindings, constraint)
    @test_throws TokenizeError("'+-' is an invalid sequence of symbols.") parse_formula("a+-b", bindings, expression)

    bindings = Bindings([], [], ["a", "b", "c"])
    ast = parse_formula("a+b-c", bindings, expression)
    @test to_string(ast) == "((a)+(b))-(c)"
    @test ast == ExpressionBinaryOperation("-", ExpressionBinaryOperation("+", VariableNode("a"), VariableNode("b")), VariableNode("c"))
    
    bindings = Bindings([], [], ["a", "b"])
    ast = parse_formula("a*sin(b)", bindings, expression)
    @test ast == ExpressionBinaryOperation("*", VariableNode("a"), ExpressionUnaryOperation("sin", VariableNode("b")))
    @test to_string(ast) == "(a)*(sin(b))"

    bindings = Bindings([], [], [])
    ast = parse_formula("cot(0)/10", bindings, expression)
    @test ast == ExpressionBinaryOperation("/", ExpressionUnaryOperation("cot", ExpressionConstant(0.0)), ExpressionConstant(10.0))
    @test to_string(ast) == "(cot(0.0))/(10.0)"
    @test ast == parse_formula("(cot(((0)))/(10))", bindings, expression)

    bindings = Bindings([], [], ["x", "y", "z"])
    ast = parse_formula("x + y * z", bindings, expression)
    @test ast == ExpressionBinaryOperation("+", VariableNode("x"), ExpressionBinaryOperation("*", VariableNode("y"), VariableNode("z")))
    @test to_string(ast) == "(x)+((y)*(z))"
    @test ast == parse_formula("x + (y * z)", bindings, expression)
    @test ast == parse_formula("x + (y) * z", bindings, constraint)

    ast = parse_formula("x - y * z", bindings, expression)
    @test ast == ExpressionBinaryOperation("-", VariableNode("x"), ExpressionBinaryOperation("*", VariableNode("y"), VariableNode("z")))
    @test to_string(ast) == "(x)-((y)*(z))"
    @test ast == parse_formula("x - (y * z)", bindings, expression)
    @test ast == parse_formula("x - (y) * z", bindings, constraint)

    ast = parse_formula("x * y - z", bindings, expression)
    @test ast == ExpressionBinaryOperation("-", ExpressionBinaryOperation("*", VariableNode("x"), VariableNode("y")), VariableNode("z"))
    @test to_string(ast) == "((x)*(y))-(z)"
    @test ast == parse_formula("(x * y) - z", bindings, expression)
    @test ast == parse_formula("x * y - (z)", bindings, constraint)

    bindings = Bindings([], [], ["y", "z"])
    ast = parse_formula("-y * z", bindings, expression)
    @test ast == ExpressionBinaryOperation("*", ExpressionUnaryOperation("-", VariableNode("y")), VariableNode("z"))
    @test to_string(ast) == "(-(y))*(z)"
    @test ast == parse_formula("-(y) * z", bindings, expression)
    @test ast != parse_formula("-(y * z)", bindings, constraint)

    bindings = Bindings([], [], ["x", "y", "z"])
    ast = parse_formula("x ^ y - z * 10", bindings, expression)
    @test ast == ExpressionBinaryOperation(
        "-",
        ExpressionBinaryOperation("^", VariableNode("x"), VariableNode("y")),
        ExpressionBinaryOperation("*", VariableNode("z"), ExpressionConstant(10.0))
    )
    @test to_string(ast) == "((x)^(y))-((z)*(10.0))"

    ast = parse_formula("min(max(x, y), z)", bindings, expression)
    @test ast == ExpressionBinaryOperation("min", ExpressionBinaryOperation("max", VariableNode("x"), VariableNode("y")), VariableNode("z"))
    @test to_string(ast) == "min(max(x,y),z)"

    # test constraints

    bindings = Bindings([], [], ["x", "y"])
    ast = parse_formula("x < y + 10", bindings, constraint)
    @test ast == ConstraintBinaryOperation("<", VariableNode("x"), ExpressionBinaryOperation("+", VariableNode("y"), ExpressionConstant(10.0)))
    @test to_string(ast) == "(x)<((y)+(10.0))"
    @test ast == parse_formula("x < (y + 10)", bindings, constraint)
    @test ast == parse_formula("(x < (y + 10))", bindings, state)
    @test ast == parse_formula("(x) < (y + 10)", bindings, strategy)
    @test ast == parse_formula("((x) < (y + 10))", bindings, strategy)
    @test_throws ParseError("Cannot parse tokens '(x)<(y)', '+', '10.0'.") parse_formula("(x < y) + 10", bindings, constraint)

    ast = parse_formula("true && x < y", bindings, constraint)
    @test ast == ConstraintBinaryOperation("&&", ConstraintConstant(true), ConstraintBinaryOperation("<", VariableNode("x"), VariableNode("y")))
    @test to_string(ast) == "(true)&&((x)<(y))"
    @test ast == parse_formula("(true) && (x < y)", bindings, constraint)
    @test_throws ParseError("Cannot parse tokens '(', 'true', '&&', 'x', ')', '<', 'y'.") parse_formula("(true && x) < y", bindings, constraint)

    bindings = Bindings([], [], ["x"])
    ast = parse_formula("x < 10 && false", bindings, constraint)
    @test ast == ConstraintBinaryOperation("&&", ConstraintBinaryOperation("<", VariableNode("x"), ExpressionConstant(10.0)), ConstraintConstant(false))
    @test to_string(ast) == "((x)<(10.0))&&(false)"

    bindings = Bindings([], [], [])
    ast = parse_formula("true || false && false", bindings, constraint)
    @test ast == ConstraintBinaryOperation("||", ConstraintConstant(true), ConstraintBinaryOperation("&&", ConstraintConstant(false), ConstraintConstant(false)))
    @test to_string(ast) == "(true)||((false)&&(false))"

    # test states

    bindings = Bindings([], ["loc"], [])
    ast = parse_formula("true && loc", bindings, state)
    @test ast == StateBinaryOperation("&&", ConstraintConstant(true), LocationNode("loc"))
    @test to_string(ast) == "(true)&&(loc)"

    bindings = Bindings([], ["loc1", "loc2"], [])
    ast = parse_formula("true || false || !loc1 && loc2", bindings, state)
    @test ast == StateBinaryOperation(
        "||",
        ConstraintBinaryOperation("||", ConstraintConstant(true), ConstraintConstant(false)),
        StateBinaryOperation("&&", StateUnaryOperation("!", LocationNode("loc1")), LocationNode("loc2"))
    )
    @test to_string(ast) == "((true)||(false))||((!(loc1))&&(loc2))"

    # test strategies

    bindings = Bindings(["a", "b"], [], [])
    ast = parse_formula("<<a,b>> F true", bindings, strategy)
    @test ast == Quantifier(false, false, Agents(false, AgentList(["a", "b"])), ConstraintConstant(true))
    @test to_string(ast) == "<<a,b>>F(true)"
    @test ast == parse_formula("(<<a,b>> F (true))", bindings, strategy)
    @test_throws ParseError("Cannot parse tokens '<<', '(', 'a,b', ')', '>>', 'F', 'true'.") parse_formula("<<(a,b)>> F true", bindings, strategy)
    @test_throws ParseError("Cannot parse tokens '(', '<<', '(', 'a', ')', ',', '(', 'b', ')', '>>', 'F', 'true', ')'.") parse_formula("(<<(a),(b)>> F (true))", bindings, strategy)

    bindings = Bindings(["a"], [], ["x", "y"])
    ast = parse_formula("<<a>> F x>5", bindings, strategy)
    @test ast == Quantifier(
        false, false, Agents(false, AgentList(["a"])),
        ConstraintBinaryOperation(">", VariableNode("x"), ExpressionConstant(5.0))
    )
    @test to_string(ast) == "<<a>>F((x)>(5.0))"
    @test ast == parse_formula("((<< a >> F x>5))", bindings, strategy)
    @test ast == parse_formula("(<<a>> F x>5)", bindings, strategy)

    bindings = Bindings([], [], ["x", "y"])
    ast = parse_formula("<< >> F x>5 && y<10", bindings, strategy)
    @test ast == Quantifier(
        false,
        false,
        Agents(false, AgentList([])),
        ConstraintBinaryOperation(
            "&&",
            ConstraintBinaryOperation(">", VariableNode("x"), ExpressionConstant(5.0)),
            ConstraintBinaryOperation("<", VariableNode("y"), ExpressionConstant(10.0)),
        )
    )
    @test to_string(ast) == "<<>>F(((x)>(5.0))&&((y)<(10.0)))"
    @test ast == parse_formula("(<< >> F (x>5 && y<10))", bindings, strategy)
    @test ast == parse_formula("(<<>> F (x>5 && y<10))", bindings, strategy)

    bindings = Bindings([], [], [])
    ast = parse_formula("<< >> F deadlock", bindings, strategy)
    @test ast ==Quantifier(
        false,
        false,
        Agents(false, AgentList([])),
        StateConstant("deadlock")
    )
    @test to_string(ast) == "<<>>F(deadlock)"
    @test ast == parse_formula("(<< >> F (deadlock))", bindings, strategy)

    bindings = Bindings([], [], [])
    ast = parse_formula("deadlock", bindings, strategy)
    @test ast == StateConstant("deadlock")
    @test to_string(ast) == "deadlock"

    # test error handling

    @test_throws ParseError("Cannot parse tokens 'true', '&&', 'false'.") parse_formula("true && false", Bindings([], [], []), expression)
    @test_throws ParseError("Cannot parse tokens '3.0', '+', '(true)&&(false)'.") parse_formula("3 + true && false", Bindings([], [], []), constraint)
    @test_throws ParseError("Unparsed token 'F'.") parse_formula("F", Bindings([], [], []), strategy)
    @test_throws ParseError("Cannot parse tokens '14.0', '&&', 'true'.") parse_formula("14 && true", Bindings([], [], []), strategy)
    @test_throws ParseError("Cannot parse tokens '<<', 'a', ',', '>>', 'F', 'true'.") parse_formula("<<a, >> F true", Bindings(["a"], [], []), strategy)
    @test_throws ParseError("Cannot parse tokens 'true', '&&', 'var'.") parse_formula("true && var", Bindings([], [], ["var"]), strategy)
    @test_throws ParseError("Cannot parse tokens '<<>>', 'F', '<<>>G(true)'.") parse_formula("<<>> F (<<>> G true)", Bindings([], [], []), strategy)

end

end
