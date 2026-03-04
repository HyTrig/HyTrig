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


function check_termination(node::Node, termination_conditions::Termination_Conditions):: Bool
    
    if node.config.global_clock >= termination_conditions.time_limit || 
        node.level >= termination_conditions.max_steps ||
        evaluate_state(termination_conditions.state_formula, node.config)
        return true
    else
        return false
    end
end



function build_and_evaluate!(game::Game,
                             constraints::Vector{Constraint}, 
                             formula::Strategy_Formula, 
                             node::Node,
                             termination_conditions::Termination_Conditions)::Bool
    terminal = check_termination(node, termination_conditions)
    if ! terminal
        build_children!(game, constraints, node, termination_conditions)
    end
    @match formula begin
        Strategy_to_State(f) => evaluate_state(f, node.config)
        # TODO: Review Deadlocks as a State formula or a special strategy formula
        # Strategy_Deadlock() => begin
        #     all_children_passive = false
        #     if ! (isa(node, PassiveNode) || terminal)
        #         all_children_passive = true
        #         for child in node.children
        #             if ! isa(node, PassiveNode)
        #                 all_children_passive = false
        #             end
        #         end
        #     end
        #     return (! terminal && length(node.children) == 0) || all_children_passive
        # end
        All_Always(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Eventually(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        All_Eventually(agents, f) => ! build_and_evaluate!(game, constraints, Exist_Always(setdiff(game.agents, agents), State_Not(f)), node, termination_conditions)
        Exist_Always(agents, f) => begin
            if ! evaluate_state(f, node.config)
                return false
            end
            if length(node.children) == 0 || terminal
                return true
            end
            # TODO: Review agents_have_active_triggers
            children = sort_children_by_clock_and_agent(node, agents)
            agents_have_active_triggers = false
            for child in children
                if ! evaluate_state(f, child.config)
                    return false
                end
                if isa(child, TriggerNode)
                    for edge_child in child.children
                        if child.trigger.first in agents
                            if build_and_evaluate!(game, constraints, formula, edge_child, termination_conditions)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, formula, edge_child, termination_conditions)
                                return false
                            end
                        end
                    end
                end
            end
            return ! agents_have_active_triggers
        end
        Exist_Eventually(agents, f) => begin
            if evaluate_state(f, node.config)
                return true
            end
            if length(node.children) == 0 || terminal
                return false
            end
            children = sort_children_by_clock_agent(node, agents)
            agents_have_active_triggers = false
            for child in children
                if evaluate_state(f, child.config)
                    return true
                end
                if isa(child, TriggerNode)
                    for edge_child in child.children
                        if child.trigger.first in agents
                            if build_and_evaluate!(game, constraints, formula, edge_child, termination_conditions)
                                return true
                            end
                            agents_have_active_triggers = true
                        else
                            if ! build_and_evaluate!(game, constraints, formula, edge_child, termination_conditions)
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