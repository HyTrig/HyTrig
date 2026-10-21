"""
    Tokens

This file contains all token definitions needed to convert a string into an array of tokens.

# Functions:
- `to_string(token::Token)::String`: Convert a token to a string.

# Types:
- `Token`: Abstract type for all tokens.
- `KeywordToken`: Abstract type for all keywords.
- `OperatorToken`: Abstract type for all operators.
- `EmptyListToken`: Token for empty lists.
- `SeparatorToken`: Token for all valid separators.
- `CustomToken`: Abstract type for all custom names.
- `AgentToken`: Token for all user defined agents.
- `LocationToken`: Token for all user defined locations.
- `VariableToken`: Token for all user defined variables.
- `NumericToken`: Token for all numeric values.
- `BooleanToken`: Token for all boolean values.
- `StateConstantToken`: Token for deadlocks.
- `QuantifierToken`: Token for quantifier keywords.
- `StateUnaryOperatorToken`: Token for unary operations on states.
- `StateBinaryOperatorToken`: Token for binary operations on states.
- `ConstraintUnaryOperatorToken`: Token for unary operations on constraints.
- `ConstraintBinaryOperatorToken`: Token for binary operations on constraints.
- `ConstraintCompareToken`: Token for comparison operators.
- `ExpressionUnaryOperatorToken`: Token for unary operations on expressions.
- `ExpressionBinaryOperatorToken`: Token for binary operations on expressions.
- `ExpressionUnBinaryOperatorToken`: Token for ambiguous unary and binary operators.
- `ExpressionBinaryFunctionToken`: Token for binary functions on expressions.

The types are hierarchically ordered as follows:
    Token
    |-- SeparatorToken
    |-- EmptyListToken
    |-- CustomToken
    |   |-- AgentToken
    |   |-- LocationToken
    |   |-- VariableToken
    |-- NumericToken
    |-- KeywordToken
    |   |-- BooleanToken
    |   |-- StateConstantToken
    |   |-- QuantifierToken
    |-- OperatorToken
        |-- ...UnaryOperatorToken
        |-- ...BinaryOperatorToken
        |-- ConstraintCompareToken
        |-- ExpressionUnBinaryOperatorToken
        |-- ExpressionBinaryFunctionToken

# Authors:
- 
"""

export Token, KeywordToken, OperatorToken, SeparatorToken, EmptyListToken, CustomToken, NumericToken
export AgentToken, StateConstantToken, QuantifierToken
export LocationToken, StateUnaryOperatorToken, StateBinaryOperatorToken
export BooleanToken, ConstraintUnaryOperatorToken, ConstraintBinaryOperatorToken, ConstraintCompareToken
export VariableToken, ExpressionUnaryOperatorToken, ExpressionBinaryOperatorToken, ExpressionUnBinaryOperatorToken, ExpressionBinaryFunctionToken
export to_string

# abstract types for all tokens
abstract type Token
end

abstract type KeywordToken <: Token
end

abstract type OperatorToken <: Token
end

"""
    SeparatorToken <: Token

A token for all valid separators.

    SeparatorToken(type::String)

Create a SeparatorToken of type `type`.
"""
struct SeparatorToken <: Token
    type::String
end

"""
    EmptyListToken <: Token

A token for empty lists.

    EmptyListToken(type::String)

Create a EmptyListToken of type `type`.
"""
struct EmptyListToken <: Token
    type::String
end

abstract type CustomToken <: Token
end

"""
    AgentToken <: CustomToken

A token for all user defined agents.

    AgentToken(type::String)

Create a AgentToken of type `type`.
"""
struct AgentToken <: CustomToken
    type::String
end

"""
    LocationToken <: CustomToken

A token for all user defined locations.

    LocationToken(type::String)

Create a LocationToken of type `type`.
"""
struct LocationToken <: CustomToken
    type::String
end

"""
    VariableToken <: CustomToken

A token for all user defined variables.

    VariableToken(type::String)

Create a VariableToken of type `type`.
"""
struct VariableToken <: CustomToken
    type::String
end

"""
    NumericToken <: Token

A token for all numeric values.

    NumericToken(type::String)

Create a NumericToken of type `type`.
"""
struct NumericToken <: Token
    type::String
end

"""
    BooleanToken <: KeywordToken

A token for boolean constants.

    BooleanToken(type::String)

Create a BooleanToken of type `type`.
"""
struct BooleanToken <: KeywordToken
    type::String
end

"""
    QuantifierToken <: KeywordToken

A token for quantifier keywords.

    QuantifierToken(type::String)

Create a QuantifierToken of type `type`.
"""
struct QuantifierToken <: KeywordToken
    type::String
end

"""
    StateConstantToken <: KeywordToken

A token for state constants like `deadlock`.

    StateConstantToken(type::String)

Create a StateConstantToken of type `type`.
"""
struct StateConstantToken <: KeywordToken
    type::String
end

"""
    StateUnaryOperatorToken <: OperatorToken

A token for unary operators on states.

    StateUnaryOperatorToken(type::String)

Create a StateUnaryOperatorToken of type `type`.
"""
struct StateUnaryOperatorToken <: OperatorToken
    type::String
end

"""
    StateBinaryOperatorToken <: OperatorToken

A token for binary operators on states.

    StateBinaryOperatorToken(type::String)

Create a StateBinaryOperatorToken of type `type`.
"""
struct StateBinaryOperatorToken <: OperatorToken
    type::String
end

"""
    ConstraintUnaryOperatorToken <: OperatorToken

A token for unary operators on constraints.

    ConstraintUnaryOperatorToken(type::String)

Create a ConstraintUnaryOperatorToken of type `type`.
"""
struct ConstraintUnaryOperatorToken <: OperatorToken
    type::String
end

"""
    ConstraintBinaryOperatorToken <: OperatorToken

A token for binary operators on constraints.

    ConstraintBinaryOperatorToken(type::String)

Create a ConstraintBinaryOperatorToken of type `type`.
"""
struct ConstraintBinaryOperatorToken <: OperatorToken
    type::String
end

"""
    ConstraintCompareToken <: OperatorToken

A token for comparing expressions.

    ConstraintCompareToken(type::String)

Create a ConstraintCompareToken of type `type`.
"""
struct ConstraintCompareToken <: OperatorToken
    type::String
end

"""
    ExpressionUnaryOperatorToken <: OperatorToken

A token for unary operators on expressions.

    ExpressionUnaryOperatorToken(type::String)

Create a ExpressionUnaryOperatorToken of type `type`.
"""
struct ExpressionUnaryOperatorToken <: OperatorToken
    type::String
end

"""
    ExpressionBinaryOperatorToken <: OperatorToken

A token for binary operators on expressions.

    ExpressionBinaryOperatorToken(type::String)

Create a ExpressionBinaryOperatorToken of type `type`.
"""
struct ExpressionBinaryOperatorToken <: OperatorToken
    type::String
end

"""
    ExpressionUnBinaryOperatorToken <: OperatorToken

A token for ambiguous unary and binary operators on expressions.

    ExpressionUnBinaryOperatorToken(type::String)

Create a ExpressionUnBinaryOperatorToken of type `type`.
"""
struct ExpressionUnBinaryOperatorToken <: OperatorToken
    type::String
end

"""
    ExpressionBinaryFunctionToken <: OperatorToken

A token for binary functions on expressions.

    ExpressionBinaryFunctionToken(type::String)

Create a ExpressionBinaryFunctionToken of type `type`.
"""
struct ExpressionBinaryFunctionToken <: OperatorToken
    type::String
end

"""
    to_string(token::Token)::String

Convert a Token `token` to a string.

# Arguments
- `token::Token`: Token to convert.

# Examples
```julia-repl
julia> to_string(CustomToken("example"))
"example"
```
"""
function to_string(token::Token)::String
    return token.type
end
