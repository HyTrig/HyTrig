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


function get_exact(constraint::Constraint, valuation::Valuation)::Bool
    @match constraint begin
        Truth(true) => true
        Truth(false) => false
        LeQ(left, right) => evaluate(Equal(left, right), valuation)
        Less(left, right) => evaluate(Equal(right, Add(left, Const(1e-5))), valuation)
        GeQ(left, right) => evaluate(Equal(left, right), valuation)
        Greater(left, right) => evaluate(Equal(left, Add(right, Const(1e-5))), valuation)
        Equal(left, right) => evaluate(Equal(left, right), valuation)
        NotEqual(left, right) => get_exact(Greater(left, right), valuation) || get_exact(Less(left, right), valuation)
        And(left, right) => (get_exact(left, valuation) && evaluate(right, valuation)) || 
                            (evaluate(left, valuation) && get_exact(right, valuation)) || 
                            (get_exact(left, valuation) && get_exact(right, valuation))
        Or(left, right) => get_exact(left, valuation) || get_exact(right, valuation)
        Not(c) => ! get_exact(c, valuation)
        Imply(left, right) => begin
            if evaluate(left, valuation)
                get_exact(right, valuation)
            elseif evaluate(right, valuation)
                get_exact(left, valuation)
            else
                get_exact(left, valuation) && get_exact(right, valuation)
            end
        end
    end
end



function get_exact_state(formula::State_Formula, config::Configuration)::Bool
    @match formula begin
        State_Location(loc) => loc == config.location
        State_Constraint(constraint) => get_exact(constraint, config.valuation)
        State_And(left, right) => (get_exact_state(left, config) && evaluate_state(right, config)) || 
                                  (evaluate_state(left, config) && get_exact_state(right, config)) || 
                                  (get_exact_state(left, config) && get_exact_state(right, config))
        State_Or(left, right) => get_exact_state(left, config) || get_exact_state(right, config)
        State_Not(f) => ! get_exact_state(f, config)
        State_Imply(left, right) => begin
            if evaluate_state(left, config)
                get_exact_state(right, config)
            elseif evaluate_state(right, config)
                get_exact_state(left, config)
            else
                get_exact_state(left, config) && get_exact_state(right, config)
            end
        end
    end
end