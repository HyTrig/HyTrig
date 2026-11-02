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

export evaluate_state
export Assignment

# TODO: add function documentation
function get_satisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> evaluate(constraint, valuation), constraints)
end

# TODO: add function documentation
function get_unsatisfied_constraints(constraints, valuation::Valuation)
    filter(constraint -> ! evaluate(constraint, valuation), constraints)
end

# TODO: add function documentation
function evaluate_state(formula::State_Formula, config::Configuration, deadlock::Bool)::Bool
    @match formula begin
        State_Location(loc) => loc == config.location
        State_Constraint(constraint) => evaluate(constraint, config.valuation)
        State_And(left, right) => evaluate_state(left, config, deadlock) && evaluate_state(right, config, deadlock)
        State_Or(left, right) => evaluate_state(left, config, deadlock) || evaluate_state(right, config, deadlock)
        State_Not(f) => ! evaluate_state(f, config, deadlock)
        State_Imply(left, right) => ! evaluate_state(left, config, deadlock) || evaluate_state(right, config, deadlock)
        State_Deadlock() => deadlock
    end
end

# TODO: add function documentation
function is_closed(assignment::Assignment)::Tuple{Bool, Valuation}
    valuation = OrderedDict{Variable, Float64}()
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
