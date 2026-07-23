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

export check_query

# Per-location bundle of compiled functions for the timed evolution. The flow
# right-hand sides are partial (two-vector) closures driven by the solver's `u`;
# the "zero" and invariant-zero expressions are full (single-vector) closures
# that depend on the whole valuation, not on the flow specifically. `flow_to_full`
# maps each flow variable's position in `u` to its position in the full valuation
# vector, so the event condition can scatter `u` back into a full valuation before
# evaluating the full closures. All fields are concretely typed, so looking an
# entry up and reading its fields stays type-stable.
const LocCompiled = @NamedTuple{
    flow_fns::Vector{PartialFn},
    zero_fns::Vector{FullFn},
    inv_fns::Vector{FullFn},
    flow_to_full::Vector{Int},
}

# Compile, once per location, the closures the timed evolution needs. Everything
# is compiled against the game's (fixed) valuation order; the flow right-hand
# sides additionally use the location's own flow order. The result is keyed by
# location name and reused for every `essential_configurations` call, so no
# expression is ever recompiled during the search.
function _precompile_locations(game::HGT_Game,
                               zero_exprs::Vector{ExprLike},
                               full_index::AbstractDict{Variable, <:Integer})::Dict{Symbol, LocCompiled}
    cache = Dict{Symbol, LocCompiled}()
    for loc in game.locations
        flow_index = partial_variable_indices(loc.flow)
        cache[loc.name] = (
            flow_fns = compile_partial_expressions(values(loc.flow), full_index, flow_index),
            zero_fns = compile_expressions(zero_exprs, full_index),
            inv_fns  = compile_expressions(loc.invariant_zeros, full_index),
            flow_to_full = Int[full_index[var] for var in keys(loc.flow)],
        )
    end
    return cache
end

# TODO: make unexported functions private by prefixing with '_'
function check_termination(config::Configuration, level::Int64, termination_conditions::Termination_Conditions):: Bool
    if config.global_clock >= termination_conditions.time_limit || 
        level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, config, false)
        return true
    else
        return false
    end
end

# TODO: make unexported functions private by prefixing with '_'
function get_action_children(game::HGT_Game, parent::TriggerNode)::Vector{DecisionNode}
    agent = parent.reaching_trigger.first
    children = DecisionNode[]
    if parent.config.global_clock - parent.parent.config.global_clock <= 1e-4 
        zero_loop = parent.parent.zero_loop 
    else
        zero_loop = Set{Pair{Agent, Location}}()
    end
    
    for action in game.actions
        for edge in select_edges(parent.config, agent => action)
            if ! ((agent => action) in zero_loop)
                config_after_edge = discrete_transition(parent.config, edge)
                child_node = DecisionNode(parent, 
                                          agent => action, 
                                          config_after_edge, 
                                          parent.level + 1, 
                                          zero_loop ∪ Set([agent => action]), 
                                          [])
                push!(children, child_node)
            end
        end
    end
    return children
end

# TODO: make unexported functions private by prefixing with '_'
function get_time_children(game::HGT_Game,
                           compiled::Dict{Symbol, LocCompiled},
                           query_formula::State_Formula,
                           parent::Union{RootNode, DecisionNode},
                           termination_conditions::Termination_Conditions,
                           formula_agents::Vector{Agent},
                           other_agents::Vector{Agent},
                           reachability::Bool)::OrderedDict{Node, Vector{DecisionNode}}

    children::OrderedDict{Node, Vector{DecisionNode}} = OrderedDict()

    sat_triggers = Set{Constraint}()
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    final_config, path_configs = essential_configurations(parent.config,
                                                          compiled[parent.config.location.name],
                                                          remaining_time,
                                                          termination_conditions.state_formula)

    path_configs = Configuration[parent.config; path_configs; final_config]
    unique!(config -> config.global_clock, path_configs)
    

    for (i, path_config) in enumerate(path_configs)
        if evaluate(parent.config.location.invariant, path_config.valuation) 
            if evaluate_state(query_formula, path_config, false) == reachability
                children[PropertyNode(parent, path_config, parent.level)] = DecisionNode[]
                return children
            end
            if check_termination(path_config, parent.level, termination_conditions)
                children[FinalNode(parent, path_config, parent.level, false)] = DecisionNode[]
                return children
            end
            active_trigger = false
            for agent in Iterators.flatten((other_agents, formula_agents))
                for trigger in game.triggers[agent]
                    if ! (trigger in sat_triggers) && evaluate(trigger, path_config.valuation)
                        push!(sat_triggers, trigger)
                        trigger_node = TriggerNode(parent, agent => trigger, path_config, parent.level, [])
                        action_children = get_action_children(game, trigger_node)
                        active_trigger = ! isempty(action_children)
                        children[trigger_node] = action_children
                    end
                end
            end
            if ! active_trigger && length(path_configs) > i &&
                ! evaluate(parent.config.location.invariant, path_configs[i + 1].valuation) && 
                path_configs[i + 1].global_clock - path_config.global_clock < 1e-4 
                # Deadlock
                children[FinalNode(parent, path_config, parent.level, true)] = DecisionNode[]
                return children
            end
        end
    end
    return children
end

# TODO: make unexported functions private by prefixing with '_'
function build_and_evaluate!(game::HGT_Game,
                             compiled::Dict{Symbol, LocCompiled},
                             query::Strategy_Formula,
                             formula_agents::Vector{Agent},
                             other_agents::Vector{Agent},
                             node::Union{RootNode, DecisionNode},
                             termination_conditions::Termination_Conditions)::Bool
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match query begin
        Strategy_to_State(f) => begin
            children = get_time_children(game, compiled, State_Constraint(Truth(true)), node, termination_conditions, formula_agents, other_agents, false)
            return evaluate_state(f, node.config, length(children) == 1 && isa(first(children).first, FinalNode) && first(children).first.deadlock)
        end
        All_Eventually(agents, f) => ! build_and_evaluate!(game, compiled, Exist_Always(other_agents, State_Not(f)), formula_agents, other_agents, node, termination_conditions)
        All_Always(agents, f) => ! build_and_evaluate!(game, compiled, Exist_Eventually(other_agents, State_Not(f)), formula_agents, other_agents, node, termination_conditions)
        Exist_Eventually(agents, f) => begin
            if evaluate_state(f, node.config, false)
                push!(node.children, PropertyNode(node, node.config, node.level))
                return true
            end
            if terminal
                return false
            end
            children = get_time_children(game, compiled, f, node, termination_conditions, formula_agents, other_agents, true)
            if length(children) == 0
                return false
            end
            child_results = false
            for (child, action_children) in children
                if ! isa(child, TriggerNode)
                    if evaluate_state(f, child.config, isa(child, FinalNode) && child.deadlock)
                        push!(node.children, child)
                        return true
                    else
                        return false
                    end
                else
                    for action_child in action_children                        
                        child_results = build_and_evaluate!(game, compiled, query, formula_agents, other_agents, action_child, termination_conditions)
                        if child.reaching_trigger.first in agents
                            if child_results
                                push!(child.children, action_child)
                                push!(node.children, child)
                                return true
                            end
                        else
                            if ! child_results
                                return false
                            end
                            push!(child.children, action_child)
                        end
                    end
                    if ! isempty(child.children)
                        push!(node.children, child)
                    end
                end
            end
            return child_results
        end
        Exist_Always(agents, f) => begin
            if ! evaluate_state(f, node.config, false)
                return false
            end
            if terminal
                push!(node.children, FinalNode(node, node.config, node.level, false))
                return true
            end
            children = get_time_children(game, compiled, f, node, termination_conditions, formula_agents, other_agents, false)
            if length(children) == 0
                push!(node.children, FinalNode(node, node.config, node.level, true))
                return true
            end
            child_results = false
            for (child, action_children) in children
                if ! isa(child, TriggerNode)
                    if ! evaluate_state(f, child.config, isa(child, FinalNode) && child.deadlock)
                        return false
                    else
                        push!(node.children, child)
                        return true
                    end
                else
                    for action_child in action_children                        
                        child_results = build_and_evaluate!(game, compiled, query, formula_agents, other_agents, action_child, termination_conditions)
                        if child.reaching_trigger.first in agents
                            if child_results
                                push!(child.children, action_child)
                                push!(node.children, child)
                                return true
                            end
                        else
                            if ! child_results
                                return false
                            end
                            push!(child.children, action_child)
                        end
                    end
                    if ! isempty(child.children)
                        push!(node.children, child)
                    end
                end
            end
            return child_results
        end
    end
end

# TODO: write documentation for this function
function check_query(game::Game, termination_conditions::Termination_Conditions, query::Strategy_Formula)::Tuple{Bool, RootNode, Float64}
    t0 = time();
    initial_config = initial_configuration(game)
    root = RootNode(initial_config, 0, Set{Location}(), [])
    constraints = get_zero(get_all_constraints(Logic_Formula[query, termination_conditions.state_formula]) ∪ game.all_triggers)

    # Precompile every location's flow and "zero" expressions once, up front, so
    # the timed evolution never recompiles them during the search.
    full_index = variable_indices(initial_config.valuation)
    compiled = _precompile_locations(game, constraints, full_index)

    if query isa Strategy_to_State
        formula_agents = game.agents
        other_agents = Agent[]
    else
        formula_agents = query.agents
        other_agents = setdiff(game.agents, formula_agents)
    end

    result = build_and_evaluate!(game, compiled, query, formula_agents, other_agents, root, termination_conditions)

    t1 = time();
    evaluation_time = t1 - t0
    return result, root, round4(evaluation_time)
end
