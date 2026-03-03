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
export ExprLike, Const, Var, Neg, Add, Mul, Sub, Div, Expon, Modulo, Sin, CoSin, Tan, CoTan, Min, Max
export to_string, is_constant, is_linear, get_all_variables, round5

const Variable = Symbol

abstract type ExprLike end

struct Const <: ExprLike
    value::Real
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

function to_string(expr::ExprLike)::String
    @match expr begin
        Const(value) => "$value"
        Var(name) => String(name)
        Neg(expr1) => "-$(to_string(expr1))"
        Add(left, right) => "($(to_string(left)) + $(to_string(right)))"
        Mul(left, right) => "($(to_string(left)) * $(to_string(right)))"
        Sub(left, right) => "($(to_string(left)) - $(to_string(right)))"
        Div(left, right) => "($(to_string(left)) / $(to_string(right)))"
        Expon(base, power) => "($(to_string(base)) ^ $(to_string(power)))"
        Modulo(left, right) => "($(to_string(left)) % $(to_string(right)))"
        Sin(base) => "sin($(to_string(base)))"
        CoSin(base) => "cos($(to_string(base)))"
        Tan(base) => "tan($(to_string(base)))"
        CoTan(base) => "cot($(to_string(base)))"
        Min(left, right) => "min($(to_string(left)), $(to_string(right)))"
        Max(left, right) => "max($(to_string(left)), $(to_string(right)))"
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
        Sin(base) => is_constant(base)
        CoSin(base) => is_constant(base)
        Tan(base) => is_constant(base)
        CoTan(base) => is_constant(base)
        Min(left, right) => is_linear(left) && is_linear(right)
        Max(left, right) => is_linear(left) && is_linear(right)
    end
end

function round5(num::Real)::Real
    return round(num, digits=5)
end

function round5(expr::ExprLike)::ExprLike
    @match expr begin
        Const(value) => Const(round5(value))
        Var(name) => Var(name)
        Neg(expr1) => Neg(round5(expr1))
        Add(left, right) => Add(round5(left), round5(right))
        Mul(left, right) => Mul(round5(left), round5(right))
        Sub(left, right) => Sub(round5(left), round5(right))
        Div(left, right) => Div(round5(left), round5(right))
        Expon(base, power) => Expon(round5(base), round5(power))
    end
end
