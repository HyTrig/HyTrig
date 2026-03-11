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


function get_trigger_children(game::HGT_Game, parent::TriggerNode)::Vector{ActionNode}
    agent = parent.reaching_trigger.first
    children = ActionNode[]
    for action in game.actions
        for edge in select_edges(parent.config, agent => action)
            if ! (edge.target_location in parent.zero_loop)
                config_after_edge = discrete_transition(parent.config, edge)
                child_node = ActionNode(parent, agent => action, config_after_edge, parent.level, parent.zero_loop, [])
                push!(children, child_node)
            end
        end
    end
    return children
end

function evaluate_deadlock(game::HGT_Game, node::Node, children::Vector{Node})::Bool
    if isa(node, RootNode) || isa(node, ActionNode)
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

function check_termination(config::Configuration, level::Int64, termination_conditions::Termination_Conditions):: Bool
    if config.global_clock >= termination_conditions.time_limit || 
        level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, config)
        return true
    else
        return false
    end
end


function get_children(game::HGT_Game, constraints::Set{Constraint}, query_formula::Union{State_Formula, Deadlock_Formula}, parent::Union{RootNode, ActionNode}, termination_conditions::Termination_Conditions, formula_agents::Vector{Agent})::Vector{Node}
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    triggers = union_safe(game.triggers[agent] for agent in game.agents)

    final_valuation, final_time, path_configs = time_to_trigger(parent.config, constraints ∪ triggers, remaining_time)

    if isa(query_formula, State_Formula)
        state_formula_status = evaluate_state(query_formula, parent.config)
    else
        state_formula_status = true
    end
    sat_triggers = Set([])

    zero_loop = if isa(parent, RootNode) Set([parent.config.location]) else parent.zero_loop ∪ Set([parent.config.location]) end

    children = Node[]
    for agent in setdiff(game.agents, formula_agents)
        for agent_trigger in game.triggers[agent]
            if evaluate(agent_trigger, parent.config.valuation)
                push!(sat_triggers, agent_trigger)
                push!(children, TriggerNode(parent, agent => agent_trigger, parent.config, parent.level + 1, zero_loop, []))
            end
        end
    end
    for agent in formula_agents
        for agent_trigger in game.triggers[agent]
            if evaluate(agent_trigger, parent.config.valuation)
                push!(sat_triggers, agent_trigger)
                push!(children, TriggerNode(parent, agent => agent_trigger, parent.config, parent.level + 1, zero_loop, []))
            end
        end
    end


    for path_config in path_configs
        path_node_needed = true
        if check_termination(path_config, parent.level, termination_conditions)
            push!(children, EndNode(parent, path_config, parent.level + 1))
            return children
        end
        for sat_trigger in triggers
            if ! (sat_trigger in sat_triggers) && evaluate(sat_trigger, path_config.valuation)
                for agent in setdiff(game.agents, formula_agents)
                    for agent_trigger in game.triggers[agent]
                        if evaluate(agent_trigger, path_config.valuation)
                            push!(sat_triggers, agent_trigger)
                            push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, Set([]), []))
                        end
                    end
                end
                for agent in formula_agents
                    for agent_trigger in game.triggers[agent]
                        if evaluate(agent_trigger, path_config.valuation)
                            push!(sat_triggers, agent_trigger)
                            push!(children, TriggerNode(parent, agent => agent_trigger, path_config, parent.level + 1, Set([]), []))
                        end
                    end
                end
                path_node_needed = false
            end
        end 
        if path_node_needed && isa(query_formula, State_Formula)
            new_state_formula_status = evaluate_state(query_formula, path_config)
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
                             node::Union{RootNode, ActionNode},
                             termination_conditions::Termination_Conditions)::Bool
    # println(strategy_to_string(query))
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match query begin
        Strategy_to_State(f) => evaluate_state(f, node.config)
        Strategy_to_Deadlock() => begin
            children = get_children(game, constraints, State_Constraint(Truth(true)), node, termination_conditions, game.agents)
            return evaluate_deadlock(game, node, children)
        end
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Always(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if ! evaluate_inner_formula(game, f, node, children)
                return false
            end
            if length(children) == 0 || terminal
                return true
            end
            # TODO: Review agents_have_active_triggers
            agents_have_active_triggers = false
            other_agents_have_active_triggers = false
            relvant_children = Node[]
            for child in children
                push!(relvant_children, child)
                if ! evaluate_inner_formula(game, f, child, Node[])
                    for relvant_child in relvant_children
                        push!(node.children, relvant_child)
                    end
                    return false
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child)
                    for action_child in trigger_children
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                for relvant_child in relvant_children
                                    push!(node.children, relvant_child)
                                end
                                push!(child.children, action_child)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                for relvant_child in relvant_children
                                    push!(node.children, relvant_child)
                                end
                                return false
                            end
                            push!(child.children, action_child)
                            other_agents_have_active_triggers = true
                        end
                    end
                end
            end
            for relvant_child in relvant_children
                push!(node.children, relvant_child)
            end
            return ! agents_have_active_triggers && other_agents_have_active_triggers
        end
        Exist_Eventually(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if evaluate_inner_formula(game, f, node, children)
                if evaluate_deadlock(game, node, children)
                end
                return true
            end
            if length(children) == 0 || terminal
                return false
            end
            # TODO: Review agents_have_active_triggers
            agents_have_active_triggers = false
            other_agents_have_active_triggers = false
            relvant_children = Node[]
            for child in children
                push!(relvant_children, child)
                if evaluate_inner_formula(game, f, child, Node[])
                    for relvant_child in relvant_children
                        push!(node.children, relvant_child)
                    end
                    return true
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child)
                    for action_child in trigger_children
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                for relvant_child in relvant_children
                                    push!(node.children, relvant_child)
                                end
                                push!(child.children, action_child)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                for relvant_child in relvant_children
                                    push!(node.children, relvant_child)
                                end
                                return false
                            end
                            push!(child.children, action_child)
                            other_agents_have_active_triggers = true
                        end
                    end
                end
            end
            for relvant_child in relvant_children
                push!(node.children, relvant_child)
            end
            return ! agents_have_active_triggers && other_agents_have_active_triggers
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