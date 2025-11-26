include("node.jl")
include("../hybrid_atl/logic.jl")
include("time_to_trigger.jl")
include("../game_semantics/transitions.jl")
include("../hybrid_atl/termination_conditions.jl")



function check_termination(node::Node, termination_conditions::Termination_Conditions):: Bool
    
    if node.config.global_clock >= termination_conditions.time_limit || 
        node.level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, node, Set{Node}())
        return true
    else
        return false
    end
end

function build_children!(game::Game, 
                        constraints::Set{Constraint}, 
                        node::Node, 
                        termination_conditions::Termination_Conditions, 
                        terminal_nodes::Set{Node},
                        built_nodes::Set{Node})
    remaining_time = termination_conditions.time_limit - node.config.global_clock
    _, location_invariant, _ = time_to_trigger(node, State_Constraint(Not(node.config.location.invariant)), Set{Constraint}(), remaining_time)

    triggers_valuations::Dict{Agent, Vector{TriggerPath}} = Dict{Agent, Vector{TriggerPath}}()
    for agent in game.agents
        triggers_valuations[agent] = TriggerPath[]
        for trigger in game.triggers[agent]
            new_valuation, ttt, path_to_trigger = time_to_trigger(node, State_Constraint(trigger), constraints, location_invariant)
            if ttt <= remaining_time && ttt < location_invariant
                trigger_path = TriggerPath(trigger, new_valuation, ttt, path_to_trigger)
                push!(triggers_valuations[agent], trigger_path)
            end
        end
    end
    for agent in game.agents
        for trigger_path in triggers_valuations[agent]
            config_after_trigger = Configuration(node.config.location, trigger_path.end_valuation, node.config.global_clock + trigger_path.ttt)
            path_node::Node = node
            for path_config in trigger_path.path_to_trigger
                child_node = PassiveNode(path_node, agent => trigger_path.trigger, path_config, path_node.level, [])
                if check_termination(child_node, termination_conditions)
                    push!(terminal_nodes, child_node)
                end
                push!(path_node.children, child_node)
                path_node = child_node
            end
            for action in enabled_actions(config_after_trigger, agent)
                for edge in select_edges(game, config_after_trigger, agent => action)
                    config_after_edge = discrete_transition(config_after_trigger, edge)
                    child_node = ActiveNode(path_node, agent => action, trigger_path.trigger, config_after_edge, path_node.level + 1, [])
                    if check_termination(child_node, termination_conditions)
                        push!(terminal_nodes, child_node)
                    end
                    push!(path_node.children, child_node)
                end
            end
        end
    end
    if length(node.children) == 0
        new_valuation, termination_time, path_to_trigger = time_to_trigger(node, termination_conditions.state_formula, constraints, location_invariant)
        if termination_time <= remaining_time && termination_time < location_invariant
            path_node = node
            for path_config in path_to_trigger
                child_node = PassiveNode(path_node, nothing, path_config, path_node.level, [])
                if check_termination(child_node, termination_conditions)
                    push!(terminal_nodes, child_node)
                end
                push!(path_node.children, child_node)
                path_node = child_node
            end
            config_after_termination = Configuration(node.config.location, new_valuation, node.config.global_clock + termination_time)
            terminal_node = ActiveNode(path_node, nothing, nothing, config_after_termination, node.level + 1, [])
            push!(terminal_nodes, terminal_node)
            push!(path_node.children, terminal_node) # No further children since terminated
        end
    end
    push!(built_nodes, node)
end

function evaluate_and_build!(game::Game,
                             constraints::Set{Constraint}, 
                             formula::Strategy_Formula, 
                             node::Node,
                             termination_conditions::Termination_Conditions,
                             terminal_nodes::Set{Node},
                             built_nodes::Set{Node}
                             )::Bool
    @match formula begin
        Strategy_to_State(f) => begin
            if ! (isa(node, PassiveNode) || (node in built_nodes))
                build_children!(game, constraints, node, termination_conditions, terminal_nodes, built_nodes)
            end
            return evaluate_state(f, node, terminal_nodes)
        end
        All_Always(agents, f) => ! evaluate_and_build!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), Strategy_Not(f)), node, termination_conditions, terminal_nodes, built_nodes)
        All_Eventually(agents, f) => ! evaluate_and_build!(game, constraints, Exist_Always(setdiff(game.agents, agents), Strategy_Not(f)), node, termination_conditions, terminal_nodes, built_nodes)
        Strategy_And(left, right) => evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes) && evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes)
        Strategy_Or(left, right) => evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes) || evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes)
        Strategy_Not(f) => ! evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes)
        Strategy_Imply(left, right) => ! evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes) || evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes)
        Exist_Always(agents, f) => begin
            if ! evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes)
                return false
            end
            if ! (isa(node, PassiveNode) || (node in built_nodes))
                build_children!(game, constraints, node, termination_conditions, terminal_nodes, built_nodes)
            end
            if length(node.children) == 0 || node in terminal_nodes
                return true
            end
            children = sort_children_by_clock_agent(node, agents)
            agents_have_children = false
            for child in children
                if child.reaching_decision.first in agents
                    if evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes,)
                        return true
                    end
                    agents_have_children = true
                elseif ! evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes)
                    return false
                end
            end
            if agents_have_children
                return false
            else
                return true
            end
        end
        Exist_Eventually(agents, f) => begin
            if evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes)
                return true
            end
            if ! (isa(node, PassiveNode) || (node in built_nodes))
                build_children!(game, constraints, node, termination_conditions, terminal_nodes, built_nodes)
            end
            if length(node.children) == 0 || node in terminal_nodes 
                return false
            end
            children = sort_children_by_clock_agent(node, agents)
            agents_have_children = false
            for child in children
                if child.reaching_decision.first in agents
                    if evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes)
                        return true
                    end
                    agents_have_children = true
                elseif ! evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes)
                    return false
                end
            end
            if agents_have_children
                return false
            else
                return true
            end
        end
    end
end


function evaluate_queries(game::Game, termination_conditions::Termination_Conditions, queries::Vector{Strategy_Formula}) 
    initial_config = initial_configuration(game)
    root = RootNode(initial_config, 0, [])
    # push!(root_father.children, root)
    constraints = get_all_constraints(queries ∪ State_Formula[termination_conditions.state_formula])

    results = Vector{Bool}()
    terminal_nodes = Set{Node}()
    built_nodes = Set{Node}()
    for query in queries
        result = evaluate_and_build!(game, constraints, query, root, termination_conditions, terminal_nodes, built_nodes)
        push!(results, result)
    end
    return results, root
end
