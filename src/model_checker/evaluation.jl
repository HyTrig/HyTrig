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

export evaluate, evaluate_state
export Assignment

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

function get_satisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> evaluate(constraint, valuation), constraints)
end

function get_unsatisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> ! evaluate(constraint, valuation), constraints)
end

function evaluate_state(formula::State_Formula, config::Configuration)::Bool
    @match formula begin
        State_Location(loc) => loc == config.location
        State_Constraint(constraint) => evaluate(constraint, config.valuation)
        State_And(left, right) => evaluate_state(left, config) && evaluate_state(right, config)
        State_Or(left, right) => evaluate_state(left, config) || evaluate_state(right, config)
        State_Not(f) => ! evaluate_state(f, config)
        State_Imply(left, right) => ! evaluate_state(left, config) || evaluate_state(right, config)
    end
end

function is_closed(assignment::Assignment)::Tuple{Bool, Valuation}
    valuation = OrderedDict{Variable, Real}()
    changed = true
    while changed && ! (Set(keys(assignment)) ⊆ Set(keys(valuation)))
        changed = false
        for (var, value) in assignment
            if ! (var in Set(keys(valuation))) && Set(get_all_variables(value)) ⊆ Set(keys(valuation))
                valuation[var] = evaluate(value, valuation)
                changed = true
            end
        end
    end
    return Set(keys(assignment)) ⊆ Set(keys(valuation)), valuation
end
