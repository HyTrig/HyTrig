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


# TODO: add function documentation
function evaluate(expr::ExprLike, valuation::Valuation)::Real
    @match expr begin
        Const(value) => value
        Var(name) => valuation[name]
        Neg(expr1) => -1 * evaluate(expr1, valuation)
        Add(left, right) => evaluate(left, valuation) + evaluate(right, valuation)
        Mul(left, right) => evaluate(left, valuation) * evaluate(right, valuation)
        Sub(left, right) => evaluate(left, valuation) - evaluate(right, valuation)
        Div(left, right) => evaluate(left, valuation) / evaluate(right, valuation)
        Expon(base, power) => evaluate(base, valuation) ^ evaluate(power, valuation)
        Modulo(left, right) => evaluate(left, valuation) % evaluate(right, valuation)
        Abs(base) => abs(evaluate(base, valuation))
        Sin(base) => sin(evaluate(base, valuation))
        CoSin(base) => cos(evaluate(base, valuation))
        Tan(base) => tan(evaluate(base, valuation))
        CoTan(base) => cot(evaluate(base, valuation))
        Min(left, right) => min(evaluate(left, valuation), evaluate(right, valuation))
        Max(left, right) => max(evaluate(left, valuation), evaluate(right, valuation))
    end
end

# TODO: add function documentation
function evaluate(constraint::Constraint, valuation::Valuation)::Bool
    @match constraint begin
        Truth(value) => value
        Less(left, right) => round4(evaluate(left, valuation)) < round4(evaluate(right, valuation))
        LeQ(left, right) => round4(evaluate(left, valuation)) <= round4(evaluate(right, valuation))
        Greater(left, right) => round4(evaluate(left, valuation)) > round4(evaluate(right, valuation))
        GeQ(left, right) => round4(evaluate(left, valuation)) >= round4(evaluate(right, valuation))
        Equal(left, right) => round4(evaluate(left, valuation)) == round4(evaluate(right, valuation))
        NotEqual(left, right) => round4(evaluate(left, valuation)) != round4(evaluate(right, valuation))
        And(left, right) => evaluate(left, valuation) && evaluate(right, valuation)
        Or(left, right) => evaluate(left, valuation) || evaluate(right, valuation)
        Not(c) => !evaluate(c, valuation)
        Imply(left, right) => !evaluate(left, valuation) || evaluate(right, valuation)
    end
end
