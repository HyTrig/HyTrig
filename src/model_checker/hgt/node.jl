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

export Node, RootNode, TriggerNode, PassiveNode, ActionNode, EndNode, DeadlockNode
export print_tree, count_nodes, depth_of_tree, max_time, print_node
export sort_children_by_clock!, sort_children_by_clock_and_agent

abstract type Node
end

struct RootNode <: Node
    config::Configuration
    level::Int64
    children::Vector{Node}
end

struct PassiveNode <: Node
    parent::Node
    config::Configuration
    level::Int64
end

struct TriggerNode <: Node
    parent::Node
    reaching_trigger::Pair{Agent, Constraint}
    config::Configuration
    level::Int64
    zero_loop::Set{Location}
    children::Vector{Node}
end

struct ActionNode <: Node
    parent::Node
    reaching_decision::Pair{Agent, Action}
    config::Configuration
    level::Int64
    zero_loop::Set{Location}
    terminal::Bool
    children::Vector{Node}
end

struct EndNode <: Node
    parent::Node
    config::Configuration
    level::Int64
end

struct DeadlockNode <: Node
    parent::Node
    config::Configuration
    level::Int64
end

function print_node(node::Node)
    @match node begin
        RootNode(config, _, children) => "Root  $(config.location.name) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))\n"
        ActionNode(_, decision, config, level, _, _, children) => "$level- Action - Agent: $(decision.first) - Action: $(decision.second) - Location: $(config.location.name) - Time: $(round5(config.global_clock)) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        TriggerNode(_, decision, config, level, _, children) => "$level- Trigger - Agent: $(decision.first) - Trigger: $(constraint_to_string(decision.second)) - Location: $(config.location.name) - Time: $(round5(config.global_clock)) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        PassiveNode(_, config, level) => "$level- Passive - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
        EndNode(_, config, level) => "$level- End - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
        DeadlockNode(_, config, level) => "$level- Deadlock - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
    end
end

function print_tree(root::Node)
    res = ""
    @match root begin
        RootNode(config, _, children) =>
            begin
                res *= "\nRoot  $(config.location.name) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))\n"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        ActionNode(_, decision, config, level, _, _, children) =>
            begin
                res *= "\n$level- Action - Agent: $(decision.first) - Action: $(decision.second) - Location: $(config.location.name) - Time: $(round5(config.global_clock)) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        TriggerNode(_, decision, config, level, _, children) =>
            begin
                res *= "\n$level- Trigger - Agent: $(decision.first) - Trigger: $(constraint_to_string(decision.second)) - Location: $(config.location.name) - Time: $(round5(config.global_clock)) - Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        PassiveNode(_, config, level) =>
            begin
                res *= "\n$level- Passive - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
                res *= "\n--------------\n"
            end
        EndNode(_, config, level) =>
            begin
                res *= "\n$level- End - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
                res *= "\n--------------\n"
            end
        DeadlockNode(_, config, level) =>
            begin
                res *= "\n$level- Deadlock - Location: $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
                res *= "\n--------------\n"
            end
    end
    return res
end

function count_nodes(root::Node)::Int
    @match root begin
        RootNode(_, _, []) => 1
        RootNode(_, _, children) => 1 + sum(count_nodes(child) for child in children)
        PassiveNode(_, _, _) => 1
        TriggerNode(_, _, _, _, _, []) => 1
        TriggerNode(_, _, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        ActionNode(_, _, _, _, _, _, []) => 1
        ActionNode(_, _, _, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        EndNode(_, _, _) => 1
        DeadlockNode(_, _, _) => 1
    end
end

function depth_of_tree(root::Node)::Int
    @match root begin
        RootNode(_, _, []) => 1
        RootNode(_, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        PassiveNode(_, _, _) => 1
        TriggerNode(_, _, _, _, _, []) => 1
        TriggerNode(_, _, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        ActionNode(_, _, _, _, _, _, []) => 1
        ActionNode(_, _, _, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        EndNode(_, _, _) => 1
        DeadlockNode(_, _, _) => 1
    end
end


function max_time(root::Node)::Float64
    @match root begin
        RootNode(_, _, []) => 0.0
        RootNode(_, _, children) => maximum(max_time(child) for child in children)
        PassiveNode(_, config, _) => round5(config.global_clock)
        TriggerNode(_, _, config, _, _, []) => round5(config.global_clock)
        TriggerNode(_, _, config, _, _, children) => maximum(max_time(child) for child in children)
        ActionNode(_, _, config, _, _, _, []) => round5(config.global_clock)
        ActionNode(_, _, config, _, _, _, children) => maximum(max_time(child) for child in children)
        EndNode(_, config, _) => round5(config.global_clock)
        DeadlockNode(_, config, _) => round5(config.global_clock)
    end
end

# function sort_children_by_clock!(root::Node)
#     # sorts children by global clock, and if two children have the same clock, the one with the agent's decision comes last
#     sort!(root.children, by = child -> child.config.global_clock)
# end

# function sort_children_by_clock_and_agent(root::Node, agents::Vector{Agent})
#     # sorts children by global clock, and if two children have the same clock, the one with the agent's decision comes last
#     sort(root.children, by = child -> (round5(child.config.global_clock), child.reaching_decision.first in agents))
# end
