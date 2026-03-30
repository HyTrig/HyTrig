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
    for action in game.actions
        for edge in select_edges(parent.config, agent => action)
            if ! (edge.target_location in parent.zero_loop)
                config_after_edge = discrete_transition(parent.config, edge)
                child_node = DecisionNode(parent, agent => action, config_after_edge, parent.level + 1, parent.zero_loop, [])
                push!(children, child_node)
            end
        end
    end
    return children
end

# TODO: make unexported functions private by prefixing with '_'
function get_time_children(game::HGT_Game, 
                           constraints::Set{Constraint}, 
                           query_formula::State_Formula, 
                           parent::Union{RootNode, DecisionNode}, 
                           termination_conditions::Termination_Conditions, 
                           formula_agents::Vector{Agent})::OrderedDict{Node, Vector{DecisionNode}}

    triggers = union_safe(game.triggers[agent] for agent in game.agents)

    state_formula_status = evaluate_state(query_formula, parent.config, false)

    zero_loop = if isa(parent, RootNode) Set([parent.config.location]) else parent.zero_loop ∪ Set([parent.config.location]) end

    children::OrderedDict{Node, Union{Nothing, Vector{DecisionNode}}} = OrderedDict()

    sat_triggers = Set([])
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    final_config, path_configs = time_to_trigger(parent.config, constraints ∪ triggers, remaining_time, termination_conditions)

    path_configs = [parent.config] ∪ path_configs ∪ [final_config]

    for (i, path_config) in enumerate(path_configs)
        if path_config.global_clock - parent.config.global_clock >= 1e-5
            zero_loop = Set([])
        end
        if evaluate(parent.config.location.invariant, path_config.valuation) 
            if isa(query_formula, State_Formula)
                new_state_formula_status = evaluate_state(query_formula, path_config, false)
                if state_formula_status != new_state_formula_status
                    state_formula_status = new_state_formula_status
                    children[PropertyNode(parent, path_config, parent.level)] = DecisionNode[]
                    return children
                end
            end
            if check_termination(path_config, parent.level, termination_conditions)
                children[FinalNode(parent, path_config, parent.level, false)] = DecisionNode[]
                return children
            end
            active_trigger = false
            for agent in setdiff(game.agents, formula_agents)
                for trigger in game.triggers[agent]
                    if ! (trigger in sat_triggers) && evaluate(trigger, path_config.valuation)
                        if evaluate(trigger, path_config.valuation)
                            push!(sat_triggers, trigger)
                            trigger_node = TriggerNode(parent, agent => trigger, path_config, parent.level, zero_loop, [])
                            action_children = get_action_children(game, trigger_node)
                            active_trigger = ! isempty(action_children)
                            children[trigger_node] = action_children
                        end
                    end
                end
            end
            for agent in formula_agents
                for trigger in game.triggers[agent]
                    if ! (trigger in sat_triggers) && evaluate(trigger, path_config.valuation)
                        if evaluate(trigger, path_config.valuation)
                            push!(sat_triggers, trigger)
                            trigger_node = TriggerNode(parent, agent => trigger, path_config, parent.level, zero_loop, [])
                            action_children = get_action_children(game, trigger_node)
                            active_trigger = ! isempty(action_children)
                            children[trigger_node] = action_children
                        end
                    end
                end
            end
            if length(path_configs) > i &&
                ! evaluate(parent.config.location.invariant, path_configs[i + 1].valuation) && 
                path_configs[i + 1].global_clock - path_config.global_clock < 1e-5 && 
                ! active_trigger        # Deadlock
                children[FinalNode(parent, path_config, parent.level, true)] = DecisionNode[]
                return children
            end
        end
    end
    return children
end

# TODO: make unexported functions private by prefixing with '_'
function build_and_evaluate!(game::HGT_Game,
                             constraints::Set{Constraint},
                             query::Strategy_Formula, 
                             node::Union{RootNode, DecisionNode},
                             termination_conditions::Termination_Conditions)::Bool
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match query begin
        Strategy_to_State(f) => begin
            children = get_time_children(game, constraints, State_Deadlock(), node, termination_conditions, agents)
            return evaluate_state(f, node.config, length(children) == 1 && isa(first(children).first, FinalNode) && first(children).first.deadlock)
        end
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Eventually(agents, f) => begin
            children = get_time_children(game, constraints, f, node, termination_conditions, agents)
            if evaluate_state(f, node.config, false)
                push!(node.children, PropertyNode(node, node.config, node.level))
                return true
            end
            if length(children) == 0 || terminal
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
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                push!(node.children, child)
                                return true
                            end
                            child_results = false
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                return false
                            end
                            push!(child.children, action_child)
                            child_results = true
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
            children = get_time_children(game, constraints, f, node, termination_conditions, agents)
            if ! evaluate_state(f, node.config, false)
                return false
            end
            if length(children) == 0 || terminal
                push!(node.children, FinalNode(node, node.config, node.level, ! terminal))
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
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                push!(node.children, child)
                                return true
                            end
                            child_results = false
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                return false
                            end
                            push!(child.children, action_child)
                            child_results = true
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
    root = RootNode(initial_config, 0, [])
    constraints = get_all_constraints(Logic_Formula[query, termination_conditions.state_formula])

    result = build_and_evaluate!(game, constraints, query, root, termination_conditions)

    t1 = time();
    evaluation_time = t1 - t0
    return result, root, round5(evaluation_time)
end
