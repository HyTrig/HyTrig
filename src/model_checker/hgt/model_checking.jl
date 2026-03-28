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

function check_termination(config::Configuration, level::Int64, termination_conditions::Termination_Conditions):: Bool
    if config.global_clock >= termination_conditions.time_limit || 
        level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, config)
        return true
    else
        return false
    end
end

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

function get_time_children(game::HGT_Game, 
                           constraints::Set{Constraint}, 
                           query_formula::Union{State_Formula, Deadlock_Formula}, 
                           parent::Union{RootNode, DecisionNode}, 
                           termination_conditions::Termination_Conditions, 
                           formula_agents::Vector{Agent})::OrderedDict{Node, Vector{DecisionNode}}

    triggers = union_safe(game.triggers[agent] for agent in game.agents)

    if isa(query_formula, State_Formula)
        state_formula_status = evaluate_state(query_formula, parent.config)
    else
        state_formula_status = true
    end

    zero_loop = if isa(parent, RootNode) Set([parent.config.location]) else parent.zero_loop ∪ Set([parent.config.location]) end

    children::OrderedDict{Node, Union{Nothing, Vector{DecisionNode}}} = OrderedDict()

    sat_triggers = Set([])
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    final_config, path_configs = time_to_trigger(parent.config, constraints ∪ triggers, remaining_time, termination_conditions)

    path_configs = [parent.config] ∪ path_configs ∪ [final_config]

    for path_config in path_configs
        if path_config.global_clock - parent.config.global_clock >= 1e-5
            zero_loop = Set([])
        end
        if evaluate(parent.config.location.invariant, path_config.valuation) 
            if isa(query_formula, State_Formula)
                new_state_formula_status = evaluate_state(query_formula, path_config)
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
            if final_config.global_clock - path_config.global_clock <= 1e-5 && ! active_trigger
                # Deadlock
                children[FinalNode(parent, path_config, parent.level, true)] = DecisionNode[]
                return children
            end
        end
    end
    return children
end

function build_and_evaluate!(game::HGT_Game,
                             constraints::Set{Constraint},
                             query::Strategy_Formula, 
                             node::Union{RootNode, DecisionNode},
                             termination_conditions::Termination_Conditions)::Bool
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match query begin
        Strategy_to_State(f) => evaluate_state(f, node.config)
        Strategy_to_Deadlock() => begin
            append!(node.children, get_time_children(game, constraints, State_Constraint(Truth(true)), node, termination_conditions, game.agents))
            return isempty(node.children)
        end
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Eventually(agents, f) => begin
            children = get_time_children(game, constraints, f, node, termination_conditions, agents)
            if isa(f, State_Formula) && evaluate_state(f, node.config)
                push!(node.children, PropertyNode(node, node.config, node.level))
                return true
            end
            if terminal
                return false
            end
            if length(children) == 0
                if isa(f, Deadlock_Formula)
                    push!(node.children, FinalNode(node, node.config, node.level, true))
                    return true
                end
                return false
            end
            child_results = false
            for (child, action_children) in children
                if isa(child, PropertyNode)
                    push!(node.children, child)
                    return true
                elseif isa(child, FinalNode)
                    return false
                elseif isa(child, TriggerNode)
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
            if isa(f, State_Formula) && ! evaluate_state(f, node.config)
                return false
            end
            if length(children) == 0 || terminal
                push!(node.children, FinalNode(node, node.config, node.level, ! terminal))
                return true
            end
            child_results = false
            for (child, action_children) in children
                if isa(child, PropertyNode)
                    return false
                elseif isa(child, FinalNode)
                    push!(node.children, child)
                    return true
                elseif isa(child, TriggerNode)
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

function check_query(game::Game, termination_conditions::Termination_Conditions, query::Strategy_Formula) 
    initial_config = initial_configuration(game)
    root = RootNode(initial_config, 0, [])
    constraints = get_all_constraints(Logic_Formula[query, termination_conditions.state_formula])

    result = build_and_evaluate!(game, constraints, query, root, termination_conditions)

    return result, root
end