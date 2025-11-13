include("node.jl")
include("../hybrid_atl/logic.jl")
include("../game_tree/time_to_trigger.jl")
include("../game_tree/triggers_based_game_tree.jl")


struct TriggerPathOnDemand
    trigger::Constraint
    end_valuation::Valuation
    ttt::Float64
    path_to_trigger::Vector{Configuration}
end

function check_termination_on_demand(node::NodeOnDemand, level::Int, termination_conditions):: Bool
    
    if node.config.global_clock >= termination_conditions["time-bound"] || 
        level >= termination_conditions["max-steps"] ||
        evaluate_state(termination_conditions["state-formula"], node, Set{NodeOnDemand}())
        return true
    else
        return false
    end
    
end

# function build_game_tree(game::Game, termination_conditions, queries::Vector{Strategy_Formula}):: Node
#     constraints = get_all_constraints(queries ∪ State_Formula[termination_conditions["state-formula"]])
#     return build_game_tree_on_demand(game, constraints, termination_conditions)
# end

function build_children!(game::Game, 
                        constraints::Set{Constraint}, 
                        node::NodeOnDemand, 
                        termination_conditions, 
                        level::Int,
                        terminal_nodes::Set{NodeOnDemand},
                        built_nodes::Set{NodeOnDemand})
    remaining_time = termination_conditions["time-bound"] - node.config.global_clock
    _, location_invariant, _ = time_to_trigger(node.config, Not(node.config.location.invariant), Set{Constraint}(), remaining_time)

    triggers_valuations::Dict{Agent, Vector{TriggerPathOnDemand}} = Dict{Agent, Vector{TriggerPath}}()
    for agent in game.agents
        triggers_valuations[agent] = TriggerPathOnDemand[]
        for trigger in game.triggers[agent]
            new_valuation, ttt, path_to_trigger = time_to_trigger(node.config, trigger, constraints, location_invariant)
            if ttt <= remaining_time && ttt < location_invariant
                trigger_path = TriggerPathOnDemand(trigger, new_valuation, ttt, path_to_trigger)
                push!(triggers_valuations[agent], trigger_path)
            end
        end
    end

    for agent in game.agents
        for trigger_path in triggers_valuations[agent]
            config_after_trigger = Configuration(node.config.location, trigger_path.end_valuation, node.config.global_clock + trigger_path.ttt)
            for action in enabled_actions(config_after_trigger, agent)
                for edge in select_edges(game, config_after_trigger, agent => action)
                    config_after_edge = discrete_transition(config_after_trigger, edge)
                    path_node = node
                    for path_config in trigger_path.path_to_trigger
                        child_node = NodeOnDemand(path_node, agent => action, true, path_config, [])
                        # child_node.terminal_node = check_termination_on_demand(child_node, level, termination_conditions)
                        if check_termination_on_demand(child_node, level, termination_conditions)
                            push!(terminal_nodes, child_node)
                        end
                        push!(path_node.children, child_node)
                        path_node = child_node
                    end
                    child_node = NodeOnDemand(path_node, agent => action, false, config_after_edge, [])
                    # child_node.terminal_node = check_termination_on_demand(child_node, level + 1, termination_conditions)
                    if check_termination_on_demand(child_node, level, termination_conditions)
                        push!(terminal_nodes, child_node)
                    end
                    push!(path_node.children, child_node)
                end
            end
        end
    end 
    # node.children_built = true
    push!(built_nodes, node)
end


function evaluate_state(formula::State_Formula, node::NodeOnDemand, terminal_nodes::Set{NodeOnDemand})::Bool
    @match formula begin
        State_Location(loc) => loc == node.config.location
        State_Constraint(constraint) => evaluate(constraint, node.config.valuation)
        State_And(left, right) => evaluate_state(left, node.config, terminal_nodes) && evaluate_state(right, node.config, terminal_nodes)
        State_Or(left, right) => evaluate_state(left, node.config, terminal_nodes) || evaluate_state(right, node.config, terminal_nodes)
        State_Not(f) => ! evaluate_state(f, node.config, terminal_nodes)
        State_Imply(left, right) => ! evaluate_state(left, node.config, terminal_nodes) || evaluate_state(right, node.config, terminal_nodes)
        State_Deadlock() => ! (node in terminal_nodes) && length(node.children) == 0
    end
end

function evaluate_and_build!(game::Game,
                             constraints::Set{Constraint}, 
                             formula::Strategy_Formula, 
                             node::NodeOnDemand,
                             termination_conditions::Dict{String, Any},
                             terminal_nodes::Set{NodeOnDemand},
                             built_nodes::Set{NodeOnDemand},
                            #  path::Vector{NodeOnDemand}=NodeOnDemand[],
                             level::Int=0
                             )::Bool
    @match formula begin
        Strategy_to_State(f) => begin
            if ! (node in built_nodes) # .children_built == false
                build_children!(game, constraints, node, termination_conditions, level, terminal_nodes, built_nodes)
            end
            return evaluate_state(f, node, terminal_nodes)
        end
        All_Always(agents, f) => ! evaluate_and_build!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), Strategy_Not(f)), node, termination_conditions, terminal_nodes, built_nodes, level)
        All_Eventually(agents, f) => ! evaluate_and_build!(game, constraints, Exist_Always(setdiff(game.agents, agents), Strategy_Not(f)), node, termination_conditions, terminal_nodes, built_nodes, level)
        Strategy_And(left, right) => evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes, level) && evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes, level)
        Strategy_Or(left, right) => evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes, level) || evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes, level)
        Strategy_Not(f) => ! evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes, level)
        Strategy_Imply(left, right) => ! evaluate_and_build!(game, constraints, left, node, termination_conditions, terminal_nodes, built_nodes, level) || evaluate_and_build!(game, constraints, right, node, termination_conditions, terminal_nodes, built_nodes, level)
        Exist_Always(agents, f) => begin
            if ! evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes, level)
                return false
            end
            if ! (node in built_nodes) # .children_built == false
                build_children!(game, constraints, node, termination_conditions, level, terminal_nodes, built_nodes)
            end
            if length(node.children) == 0 || node in terminal_nodes # .terminal_node
                return true
            end
            if node.passive_node
                return evaluate_and_build!(game, constraints, formula, node.children[1], termination_conditions, terminal_nodes, built_nodes, level)
            end
            children = sort_children_by_clock_agent_on_demand(node, agents)
            agents_have_children = false
            for child in children
                if child.reaching_decision.first in agents
                    if evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes, level + 1)
                        return true
                    end
                    agents_have_children = true
                else 
                    if ! evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes, level + 1)
                        return false
                    end
                end
            end
            if agents_have_children
                return false
            else
                return true
            end
        end
        Exist_Eventually(agents, f) => begin
            if evaluate_and_build!(game, constraints, f, node, termination_conditions, terminal_nodes, built_nodes, level)
                return true
            end
            if ! (node in built_nodes) # .children_built == false
                build_children!(game, constraints, node, termination_conditions, level, terminal_nodes, built_nodes)
            end
            if length(node.children) == 0 || node in terminal_nodes # .terminal_node
                return false
            end
            if node.passive_node
                return evaluate_and_build!(game, constraints, formula, node.children[1], termination_conditions, terminal_nodes, built_nodes, level)
            end
            children = sort_children_by_clock_agent_on_demand(node, agents)
            agents_have_children = false
            for child in children
                if child.reaching_decision.first in agents
                    if evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes, level + 1)
                        return true
                    end
                    agents_have_children = true
                else 
                    if ! evaluate_and_build!(game, constraints, formula, child, termination_conditions, terminal_nodes, built_nodes, level + 1)
                        return false
                    end
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


function evaluate_queries(game::Game, termination_conditions, queries::Vector{Strategy_Formula}) #::(Vector{Bool}, NodeOnDemand)
    initial_config = initial_configuration(game)
    root = NodeOnDemand(nothing, nothing, false, initial_config, [])
    constraints = get_all_constraints(queries ∪ State_Formula[termination_conditions["state-formula"]])

    results = Vector{Bool}()
    terminal_nodes = Set{NodeOnDemand}()
    built_nodes = Set{NodeOnDemand}()
    for formula in queries
        push!(results, evaluate_and_build!(game, constraints, formula, root, termination_conditions, terminal_nodes, built_nodes, 0))
    end
    println("Built nodes count: ", length(built_nodes))
    println("Built terminal nodes count: ", length(terminal_nodes))

    return results, root
end