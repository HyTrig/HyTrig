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

export Node, RootNode, TriggerNode, PassiveNode, ActionNode, EndNode
export print_tree, count_nodes, depth_of_tree, max_time, print_node
export sort_children_by_clock!, sort_children_by_clock_and_agent

# abstract type for nodes in the game tree
abstract type Node end

# TODO: add type documentation
struct RootNode <: Node
    config::Configuration
    level::Int64
    children::Vector{Node}
end

# TODO: add type documentation
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

# TODO: add type documentation
struct EndNode <: Node
    parent::Node
    config::Configuration
    level::Int64
end

function print_node(node::Node)
    @match node begin
        RootNode(config, _, children) => "0- RootNode  $(config.location.name) - # Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        ActionNode(_, decision, config, level, _, _, children) => "$level- DecisionNode $(config.location.name) - Time: $(round5(config.global_clock)) - Agent: $(decision.first) - " *
                                                                 "Action: $(decision.second) - # Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        TriggerNode(_, decision, config, level, _, children) => "$level- TriggerNode $(config.location.name) - Time: $(round5(config.global_clock)) - Agent: $(decision.first) - " *
                                                                "Trigger: $(constraint_to_string(decision.second)) - # Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        PassiveNode(_, config, level) => "$level- PassiveNode - $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
        EndNode(_, config, level) => "$level- TerminalNode - $(config.location.name) - Time: $(round5(config.global_clock))\nValuation: $(valuation_to_string(config.valuation))"
    end
end

# TODO: add function documentation
function print_tree(root::Node)
    res = "$(print_node(root))\n\n"
    if :children in fieldnames(typeof(root))
        for child in root.children
            res *= "$(print_tree(child))"
        end
    end
    return res
end

# TODO: add function documentation
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
    end
end

# TODO: add function documentation
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
    end
end