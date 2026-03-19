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

export Variable
export ExprLike, Const, Var, Neg, Add, Mul, Sub, Div, Expon, Modulo, Abs, Sin, CoSin, Tan, CoTan, Min, Max
export expression_to_string, is_constant, is_linear, get_all_variables, round5

const Variable = Symbol

abstract type ExprLike end

struct Const <: ExprLike
    value::Float64
end

struct Var <: ExprLike
    name::Variable
end

struct Neg <: ExprLike
    expr::ExprLike
end

struct Add <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Mul <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Sub <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Div <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Expon <: ExprLike
    base::ExprLike
    power::ExprLike
end

struct Modulo <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Abs <: ExprLike
    expr::ExprLike
end

struct Sin <: ExprLike
    base::ExprLike
end

struct CoSin <: ExprLike
    base::ExprLike
end

struct Tan <: ExprLike
    base::ExprLike
end

struct CoTan <: ExprLike
    base::ExprLike
end

struct Min <: ExprLike
    left::ExprLike
    right::ExprLike
end

struct Max <: ExprLike
    left::ExprLike
    right::ExprLike
end

function expression_to_string(expr::ExprLike)::String
    @match expr begin
        Const(value) => "$value"
        Var(name) => String(name)
        Neg(expr1) => "-$(expression_to_string(expr1))"
        Add(left, right) => "($(expression_to_string(left)) + $(expression_to_string(right)))"
        Mul(left, right) => "($(expression_to_string(left)) * $(expression_to_string(right)))"
        Sub(left, right) => "($(expression_to_string(left)) - $(expression_to_string(right)))"
        Div(left, right) => "($(expression_to_string(left)) / $(expression_to_string(right)))"
        Expon(base, power) => "($(expression_to_string(base)) ^ $(expression_to_string(power)))"
        Modulo(left, right) => "($(expression_to_string(left)) % $(expression_to_string(right)))"
        Abs(expr) => "|$(expression_to_string(expr))|"
        Sin(base) => "sin($(expression_to_string(base)))"
        CoSin(base) => "cos($(expression_to_string(base)))"
        Tan(base) => "tan($(expression_to_string(base)))"
        CoTan(base) => "cot($(expression_to_string(base)))"
        Min(left, right) => "min($(expression_to_string(left)), $(expression_to_string(right)))"
        Max(left, right) => "max($(expression_to_string(left)), $(expression_to_string(right)))"
    end
end

function is_constant(expr::ExprLike)::Bool
    @match expr begin
        Const(_) => true
        Var(_) => false
        Neg(expr1) => is_constant(expr1)
        Add(left, right) => is_constant(left) && is_constant(right)
        Mul(left, right) => is_constant(left) && is_constant(right)
        Sub(left, right) => is_constant(left) && is_constant(right)
        Div(left, right) => is_constant(left) && is_constant(right)
        Expon(base, power) => is_constant(base) && is_constant(power)
        Modulo(left, right) => is_constant(left) && is_constant(right)
        Abs(base) => is_constant(base)
        Sin(base) => is_constant(base)
        CoSin(base) => is_constant(base)
        Tan(base) => is_constant(base)
        CoTan(base) => is_constant(base)
        Min(left, right) => is_constant(left) && is_constant(right)
        Max(left, right) => is_constant(left) && is_constant(right)
    end
end

function is_linear(expr::ExprLike)::Bool
    @match expr begin
        Const(_) => true
        Var(_) => true
        Neg(expr1) => is_linear(expr1)
        Add(left, right) => is_linear(left) && is_linear(right)
        Sub(left, right) => is_linear(left) && is_linear(right)
        Mul(left, right) => (is_constant(left) || is_constant(right)) && (is_linear(left) || is_linear(right))
        Div(left, right) => is_linear(left) && is_constant(right) && (is_linear(left) || is_linear(right))
        Expon(base, power) => is_linear(base) && is_constant(power)
        Modulo(left, right) => is_linear(left) && is_constant(right) && (is_linear(left) || is_linear(right))
        Abs(base) => is_constant(base)
        Sin(base) => is_constant(base)
        CoSin(base) => is_constant(base)
        Tan(base) => is_constant(base)
        CoTan(base) => is_constant(base)
        Min(left, right) => is_linear(left) && is_linear(right)
        Max(left, right) => is_linear(left) && is_linear(right)
    end
end

function round5(num::Float64, digits=5)::Float64
    return round(num, digits=digits)
end

# TODO: Fill out this function
function round5(expr::ExprLike, digits=5)::ExprLike
    @match expr begin
        Const(value) => Const(round5(value, digits))
        Var(name) => Var(name)
        Neg(expr1) => Neg(round5(expr1, digits))
        Add(left, right) => Add(round5(left, digits), round5(right, digits))
        Mul(left, right) => Mul(round5(left, digits), round5(right, digits))
        Sub(left, right) => Sub(round5(left, digits), round5(right, digits))
        Div(left, right) => Div(round5(left, digits), round5(right, digits))
        Expon(base, power) => Expon(round5(base, digits), round5(power, digits))
    end
end
