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

function get_trigger_children(game::HGT_Game, parent::TriggerNode, termination_conditions::Termination_Conditions)::Vector{ActionNode}
    agent = parent.reaching_trigger.first
    children = ActionNode[]
    for action in game.actions
        for edge in select_edges(parent.config, agent => action)
            if ! (edge.target_location in parent.zero_loop)
                config_after_edge = discrete_transition(parent.config, edge)
                terminal = check_termination(config_after_edge, parent.level, termination_conditions)
                child_node = ActionNode(parent, agent => action, config_after_edge, parent.level + 1, parent.zero_loop, terminal, [])
                push!(children, child_node)
            end
        end
    end
    return children
end

function get_children(game::HGT_Game, constraints::Set{Constraint}, query_formula::Union{State_Formula, Deadlock_Formula}, parent::Union{RootNode, ActionNode}, termination_conditions::Termination_Conditions, formula_agents::Vector{Agent})::Vector{Node}

    triggers = union_safe(game.triggers[agent] for agent in game.agents)

    if isa(query_formula, State_Formula)
        state_formula_status = evaluate_state(query_formula, parent.config)
    else
        state_formula_status = true
    end

    zero_loop = if isa(parent, RootNode) Set([parent.config.location]) else parent.zero_loop ∪ Set([parent.config.location]) end

    children = Node[]
    for agent in setdiff(game.agents, formula_agents)
        for trigger in game.triggers[agent]
            if evaluate(trigger, parent.config.valuation)
                push!(children, TriggerNode(parent, agent => trigger, parent.config, parent.level, zero_loop, []))
            end
        end
    end
    for agent in formula_agents
        for trigger in game.triggers[agent]
            if evaluate(trigger, parent.config.valuation)
                push!(children, TriggerNode(parent, agent => trigger, parent.config, parent.level, zero_loop, []))
            end
        end
    end

    sat_triggers = Set([])
    remaining_time = termination_conditions.time_limit - parent.config.global_clock
    final_config, path_configs = time_to_trigger(parent.config, constraints ∪ triggers, remaining_time)

    for path_config in path_configs
        if check_termination(path_config, parent.level, termination_conditions)
            push!(children, EndNode(parent, path_config, parent.level))
            return children
        end
        for agent in setdiff(game.agents, formula_agents)
            for trigger in game.triggers[agent]
                if ! (trigger in sat_triggers) && evaluate(trigger, path_config.valuation)
                    if evaluate(trigger, path_config.valuation)
                        push!(sat_triggers, trigger)
                        push!(children, TriggerNode(parent, agent => trigger, path_config, parent.level, Set([]), []))
                    end
                end
            end
        end
        for agent in formula_agents
            for trigger in game.triggers[agent]
                if ! (trigger in sat_triggers) && evaluate(trigger, path_config.valuation)
                    if evaluate(trigger, path_config.valuation)
                        push!(sat_triggers, trigger)
                        push!(children, TriggerNode(parent, agent => trigger, path_config, parent.level, Set([]), []))
                    end
                end
            end
        end
        if isa(query_formula, State_Formula)
            new_state_formula_status = evaluate_state(query_formula, path_config)
            if state_formula_status != new_state_formula_status
                state_formula_status = new_state_formula_status
                push!(children, PassiveNode(parent, path_config, parent.level))
            end
        end
    end
    if (isempty(children) || final_config.global_clock > children[end].config.global_clock) && check_termination(final_config, parent.level, termination_conditions)
        push!(children, EndNode(parent, final_config, parent.level))
    end
    # for child in children
    #     println(print_node(child))
    # end
    # println("-----------------------")
    return children
end

function build_and_evaluate!(game::HGT_Game,
                             constraints::Set{Constraint},
                             query::Strategy_Formula, 
                             node::Union{RootNode, ActionNode},
                             termination_conditions::Termination_Conditions)::Bool
    terminal::Bool = check_termination(node.config, node.level, termination_conditions)
    @match query begin
        Strategy_to_State(f) => evaluate_state(f, node.config)
        Strategy_to_Deadlock() => begin
            append!(node.children, get_children(game, constraints, State_Constraint(Truth(true)), node, termination_conditions, game.agents))
            return isempty(node.children)
        end
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Eventually(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if isa(f, State_Formula) && evaluate_state(f, node.config)
                return true
            end
            if length(children) == 0 || terminal
                return false
            end
            agents_have_valid_decisions = false
            other_agents_have_valid_decisions = false
            relvant_children = Node[]
            for child in children
                if isa(f, State_Formula) && evaluate_state(f, child.config)
                    push!(relvant_children, child)
                    append!(node.children, relvant_children)
                    return true
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child, termination_conditions)
                    for action_child in trigger_children
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(child.children, action_child)
                                push!(relvant_children, child)
                                append!(node.children, relvant_children)
                                return true
                            end
                            agents_have_valid_decisions = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                return false
                            end
                            push!(relvant_children, child)
                            push!(child.children, action_child)
                            other_agents_have_valid_decisions = true
                        end
                    end
                else
                    push!(relvant_children, child)
                end

            end
            if ! (agents_have_valid_decisions || other_agents_have_valid_decisions)
                # Deadlock or end
                if isa(f, Deadlock_Formula)
                    append!(node.children, relvant_children)
                    return true
                else
                    return false
                end
            elseif ! agents_have_valid_decisions && other_agents_have_valid_decisions
                # Agents under consideration have no options, but others do and still satisfy the query
                append!(node.children, relvant_children)
                return true
            else
                # Agents under consideration have options, but can't satisfy the query
                return false
            end
        end
        Exist_Always(agents, f) => begin
            children = get_children(game, constraints, f, node, termination_conditions, agents)
            if isa(f, State_Formula) && ! evaluate_state(f, node.config)
                return false
            end
            if length(children) == 0 || terminal
                return true
            end
            agents_have_valid_decisions = false
            other_agents_have_valid_decisions = false
            relvant_children = Node[]
            for child in children
                if isa(f, State_Formula) && ! evaluate_state(f, child.config)
                    return false
                end
                if isa(child, TriggerNode)
                    trigger_children = get_trigger_children(game, child, termination_conditions)
                    for action_child in trigger_children
                        if child.reaching_trigger.first in agents
                            if build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                push!(relvant_children, child)
                                push!(child.children, action_child)
                                append!(node.children, relvant_children)
                                return true
                            end
                            agents_have_valid_decisions = true
                        else
                            if ! build_and_evaluate!(game, constraints, query, action_child, termination_conditions)
                                return false
                            end
                            push!(relvant_children, child)
                            push!(child.children, action_child)
                            other_agents_have_valid_decisions = true
                        end
                    end
                else
                    push!(relvant_children, child)
                end
            end
            if ! (agents_have_valid_decisions || other_agents_have_valid_decisions)
                # Deadlock or end
                if isa(f, Deadlock_Formula) || (! isempty(relvant_children) && isa(relvant_children[end], EndNode))
                    append!(node.children, relvant_children)
                    return true
                else
                    return false
                end
            elseif ! agents_have_valid_decisions && other_agents_have_valid_decisions
                # Agents under consideration have no options, but others do and still satisfy the query
                append!(node.children, relvant_children)
                return true
            else
                # Agents under consideration have options, but can't satisfy the query
                return false
            end
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