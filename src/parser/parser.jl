"""
    Parser

This module provides functionality to parse user input strings into logic formulas that can be used in the model checking process.

# Functions:
- `parse(str::String, bindings::Bindings, level::ParseLevel)`: Convert an input string into a parsed logic formula.

# Authors:
- Moritz Maas
"""

module Parser

using Match, Reexport

using ..ModelChecker.HybridATL

include("formula_parser/formula_parser.jl")
@reexport using .FormulaParser

export parse

"""
    parse(str::String, bindings::Bindings, level::ParseLevel)::Union{Strategy_Formula, State_Formula, Constraint, ExprLike, Nothing}

Convert an input string `str` into a parsed logic formula.
Calls `tokenize`, `_parse_tokens` and `_to_logic`.

# Arguments
- `str::String`: The string input to parse.
- `bindings::Bindings`: Sets of all user-binded words.
- `level::ParseLevel`: Defines level on which to parse.

# Examples
```julia-repl
julia> parse("a + b", Bindings([], [], ["a", "b"]), expression)
Add(Var(:a), Var(:b))
```
"""
function parse(str::String, bindings::Bindings, level::ParseLevel)::Union{Strategy_Formula, Deadlock_Formula, State_Formula, Constraint, ExprLike}
    ast::Union{ASTNode, Nothing} = parse_formula(str, bindings, level)
    if isnothing(ast)
        if level == constraint
            return Truth(true)
        elseif level == state
            return State_Constraint(Truth(false))
        else
            throw(ParseError("Cannot parse empty expressions or strategies."))
        end
    end

    formula = _to_logic(ast)

    if level == expression 
        if !(formula isa ExprLike)
            throw(ParseError("Formula is not an expression."))
        end
        return formula
    elseif formula isa ExprLike
        throw(ParseError("Formula is not a $level."))
    end

    if level == constraint
        if !(formula isa Constraint)
            throw(ParseError("Formula is not a constraint."))
        end
        return formula
    elseif formula isa Constraint
        formula = State_Constraint(formula)
    end

    if level == state
        if !(formula isa State_Formula)
            throw(ParseError("Formula is not a state."))
        end
        return formula
    elseif formula isa State_Formula
        formula = Strategy_to_State(formula)
    elseif formula isa Deadlock_Formula
        formula = Strategy_to_Deadlock()
    end

    return formula
end

function _to_logic(node::ConstantOperation)::Union{Deadlock_Formula, State_Location, Truth, Const, Var}
    @match node begin
        LocationNode(value) => State_Location(Symbol(value))
        StrategyConstant(value) => Deadlock_Formula()
        ConstraintConstant(value) => Truth(value)
        ExpressionConstant(value) => Const(value)
        VariableNode(value) => Var(Symbol(value))
    end
end

function _to_logic(node::ExpressionUnaryOperation)::ExprLike
    @match node.unary_operation begin
        "-" => Neg(_to_logic(node.child))
        "abs" => Abs(_to_logic(node.child))
        "sin" => Sin(_to_logic(node.child))
        "cos" => CoSin(_to_logic(node.child))
        "tan" => Tan(_to_logic(node.child))
        "cot" => CoTan(_to_logic(node.child))
    end
end

function _to_logic(node::ExpressionBinaryOperation)::ExprLike
    @match node.binary_operation begin
        "+" => Add(_to_logic(node.left_child), _to_logic(node.right_child))
        "-" => Sub(_to_logic(node.left_child), _to_logic(node.right_child))
        "*" => Mul(_to_logic(node.left_child), _to_logic(node.right_child))
        "/" => Div(_to_logic(node.left_child), _to_logic(node.right_child))
        "^" => Expon(_to_logic(node.left_child), _to_logic(node.right_child))
        "%" => Modulo(_to_logic(node.left_child), _to_logic(node.right_child))
        "min" => Min(_to_logic(node.left_child), _to_logic(node.right_child))
        "max" => Max(_to_logic(node.left_child), _to_logic(node.right_child))
    end
end

function _to_logic(node::ConstraintUnaryOperation)::Constraint
    @match node.unary_operation begin
        "!" => Not(_to_logic(node.child))
    end
end

function _to_logic(node::ConstraintBinaryOperation)::Constraint
    @match node.binary_operation begin
        "<" => Less(_to_logic(node.left_child), _to_logic(node.right_child))
        "<=" => LeQ(_to_logic(node.left_child), _to_logic(node.right_child))
        ">" => Greater(_to_logic(node.left_child), _to_logic(node.right_child))
        ">=" => GeQ(_to_logic(node.left_child), _to_logic(node.right_child))
        "==" => Equal(_to_logic(node.left_child), _to_logic(node.right_child))
        "!=" => NotEqual(_to_logic(node.left_child), _to_logic(node.right_child))
        "&&" => And(_to_logic(node.left_child), _to_logic(node.right_child))
        "||" => Or(_to_logic(node.left_child), _to_logic(node.right_child))
        "->" => Imply(_to_logic(node.left_child), _to_logic(node.right_child))
    end
end

function _to_logic(node::StateUnaryOperation)::State_Formula
    @match node.unary_operation begin
        "!" => State_Not(_to_logic(node.child))
    end
end

function _to_logic(node::StateUnaryOperation)::State_Formula
    child = _to_logic(node.child)
    if child isa Constraint
        child = State_Constraint(child)
    end
    @match node.unary_operation begin
        "!" => State_Not(child)
    end
end

function _to_logic(node::StateBinaryOperation)::State_Formula
    left_child = _to_logic(node.left_child)
    if left_child isa Constraint
        left_child = State_Constraint(left_child)
    end
    right_child = _to_logic(node.right_child)
    if right_child isa Constraint
        right_child = State_Constraint(right_child)
    end
    @match node.binary_operation begin
        "&&" => State_And(left_child, right_child)
        "||" => State_Or(left_child, right_child)
        "->" => State_Imply(left_child, right_child)
    end
end

function _to_logic(node::Quantifier)::Strategy_Formula
    child = _to_logic(node.child)
    if child isa Constraint
        child = State_Constraint(child)
    end
    if node.always
        if node.for_all
            return All_Always(_to_logic(node.agents), child)
        else
            return Exist_Always(_to_logic(node.agents), child)
        end
    else
        if node.for_all
            return All_Eventually(_to_logic(node.agents), child)
        else
            return Exist_Eventually(_to_logic(node.agents), child)
        end
    end
end

function _to_logic(node::Agents)::Vector{Agent}
    return _to_logic(node.agents)
end

function _to_logic(node::AgentList)::Vector{Agent}
    agents::Vector{Agent} = Agent[]
    for agent in node.agents
        push!(agents, Agent(Symbol(agent)))
    end
    return agents
end

end
