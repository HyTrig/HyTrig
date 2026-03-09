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


function get_trigger_children(game::HGT_Game, parent::TriggerNode)::Vector{DiscreteTransitionNode}
    children = DiscreteTransitionNode[]
    for action in game.actions
        for edge in select_edges(config, agent => action)
            if ! (edge.target_location in parent.zero_loop)
                config_after_edge = discrete_transition(config, edge)
                child_node = DiscreteTransitionNode(parent, parent.reaching_trigger[0] => action, config_after_edge, parent.level, parent.zero_loop, [])
                push!(children, child_node)
            end
        end
    end
    return children
end

function evaluate_deadlock(game::HGT_Game, node::Node, children::Vector{Node})::Bool
    if isa(node, RootNode) || isa(node, DiscreteTransitionNode)
        grand_children = [get_trigger_children(game, trigger_child) for trigger_child in children if isa(trigger_child, TriggerNode)]
        return isempty(grand_children) && ! any(isa(child, EndNode) for child in children)
    else
        return false
    end
end

function evaluate_inner_formula(game, formula::Union{State_Formula, Deadlock_Formula}, node::Node, children::Vector{Node})::Bool
    if isa(formula, State_Formula)
        return evaluate_state(formula, node.config)
    else
        return evaluate_deadlock(game, node, children)
    end
end

function check_termination(config::Configuration, level::Int32, termination_conditions::Termination_Conditions):: Bool
    if config.global_clock >= termination_conditions.time_limit || 
        level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, config)
        return true
    else
        return false
    end
end


function get_children(game::HGT_Game, constraints::Vector{Constraint}, state_formula::State_Formula, parent::Union{RootNode, DiscreteTransitionNode}, termination_conditions::Termination_Conditions, formula_agents::Set{Agent})::Vector{Node}
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    triggers = union_safe(game.triggers[agent] for agent in game.agents)

    final_valuation, final_time, path_configs = time_to_trigger(parent.config, constraints ∪ triggers, remaining_time)

    state_formula_status = evaluate_state(state_formula, parent.config)
    sat_triggers = Set([])

    zero_loop = if isa(parent, RootNode) Set([parent.config.location]) else parent.zero_loop ∪ Set([parent.config.location]) end

    children = Node[]
    for agent in setdiff(game.agents, formula_agents)
        for agent_trigger in game.triggers[agent]
            if evaluate(agent_trigger, parent.config.valuation)
                push!(sat_triggers, trigger)
                push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, zero_loop, []))
            end
        end
    end
    for agent in formula_agents
        for agent_trigger in game.triggers[agent]
            if evaluate(agent_trigger, parent.config.valuation)
                push!(sat_triggers, trigger)
                push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, zero_loop, []))
            end
        end
    end


    for path_config in path_configs
        path_node_needed = true
        if check_termination(path_config, parent.level + 1, termination_conditions)
            push!(children, EndNode(parent, path_config, parent.level + 1))
            return children
        end
        for sat_trigger in triggers
            if ! (sat_trigger in sat_triggers) && evaluate(sat_trigger, path_config.valuation)
                for agent in setdiff(game.agents, formula_agents)
                    for agent_trigger in game.triggers[agent]
                        if evaluate(agent_trigger, path_config.valuation)
                            push!(sat_triggers, trigger)
                            push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, Set([]), []))
                        end
                    end
                end
                for agent in formula_agents
                    for agent_trigger in game.triggers[agent]
                        if evaluate(agent_trigger, path_config.valuation)
                            push!(sat_triggers, trigger)
                            push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, Set([]), []))
                        end
                    end
                end
                path_node_needed = false
            end
        end 
        if path_node_needed
            new_state_formula_status = evaluate_state(state_formula, path_config)
            if state_formula_status != new_state_formula_status
                state_formula_status = new_state_formula_status
                push!(children, PassiveNode(parent, path_config, parent.level + 1))
            end
        end
    end
    return children
end

function build_and_evaluate!(game::HGT_Game,
                             constraints::Set{Constraint},
                             query::Strategy_Formula, 
                             node::Node,
                             termination_conditions::Termination_Conditions)::Bool
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match formula begin
        Strategy_to_State(f) => evaluate_state(f, node.config)
        Strategy_to_Deadlock() => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            return evaluate_deadlock(game, node, children)
        end
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Always(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if ! evaluate_inner_formula(game, f, node, children)
                return false
            end
            if length(node.children) == 0 || terminal
                return true
            end
            # TODO: Review agents_have_active_triggers
            agents_have_active_triggers = false
            for child in children
                push!(node.children, child)
                if ! evaluate_inner_formula(game, f, child, [])
                    return false
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child)
                    for action_child in child.children
                        if child.trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                return false
                            end
                        end
                    end
                end
            end
            return ! agents_have_active_triggers
        end
        Exist_Eventually(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if ! evaluate_inner_formula(game, f, node, children)
                return true
            end
            if length(node.children) == 0 || terminal
                return true
            end
            # TODO: Review agents_have_active_triggers
            agents_have_active_triggers = false
            for child in children
                push!(node.children, child)
                if ! evaluate_inner_formula(game, f, child, [])
                    return true
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child)
                    for action_child in child.children
                        if child.trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                return false
                            end
                        end
                    end
                end
            end
            return ! agents_have_active_triggers
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