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

export evaluate

function evaluate(expr::ExprLike, valuation::Valuation)::Real
    @match expr begin
        Const(value) => round5(value)
        Var(name) => round5(valuation[name])
        Neg(expr1) => round5(-1 * evaluate(expr1, valuation))
        Add(left, right) => round5(evaluate(left, valuation) + evaluate(right, valuation))
        Mul(left, right) => round5(evaluate(left, valuation) * evaluate(right, valuation))
        Sub(left, right) => round5(evaluate(left, valuation) - evaluate(right, valuation))
        Div(left, right) => round5(evaluate(left, valuation) / evaluate(right, valuation))
        Expon(base, power) => round5(evaluate(base, valuation) ^ evaluate(power, valuation))
        Modulo(left, right) => round5(evaluate(left, valuation) % evaluate(right, valuation))
        Abs(base) => round5(abs(evaluate(base, valuation)))
        Sin(base) => round5(sin(evaluate(base, valuation)))
        CoSin(base) => round5(cos(evaluate(base, valuation)))
        Tan(base) => round5(tan(evaluate(base, valuation)))
        CoTan(base) => round5(cot(evaluate(base, valuation)))
        Min(left, right) => round5(min(evaluate(left, valuation), evaluate(right, valuation)))
        Max(left, right) => round5(max(evaluate(left, valuation), evaluate(right, valuation)))
    end
end

function evaluate(constraint::Constraint, valuation::Valuation)::Bool
    @match constraint begin
        Truth(value) => value
        Less(left, right) => evaluate(left, valuation) < evaluate(right, valuation)
        LeQ(left, right) => evaluate(left, valuation) <= evaluate(right, valuation)
        Greater(left, right) => evaluate(left, valuation) > evaluate(right, valuation)
        GeQ(left, right) => evaluate(left, valuation) >= evaluate(right, valuation)
        Equal(left, right) => evaluate(left, valuation) == evaluate(right, valuation)
        NotEqual(left, right) => evaluate(left, valuation) != evaluate(right, valuation)
        And(left, right) => evaluate(left, valuation) && evaluate(right, valuation)
        Or(left, right) => evaluate(left, valuation) || evaluate(right, valuation)
        Not(c) => !evaluate(c, valuation)
        Imply(left, right) => !evaluate(left, valuation) || evaluate(right, valuation)
    end
end
