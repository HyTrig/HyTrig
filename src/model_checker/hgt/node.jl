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

export Node, RootNode, TriggerNode, PropertyNode, DecisionNode, FinalNode
export print_trees, print_tree, count_nodes, depth_of_tree, max_time, print_node
export sort_children_by_clock!, sort_children_by_clock_and_agent

# abstract type for nodes in the game tree
abstract type Node end

# TODO: add type documentation
struct RootNode <: Node
    config::Configuration
    level::Int64
    children::Vector{Node}
end

struct PropertyNode <: Node
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

struct DecisionNode <: Node
    parent::Node
    reaching_decision::Pair{Agent, Action}
    config::Configuration
    level::Int64
    zero_loop::Set{Location}
    children::Vector{Node}
end

struct FinalNode <: Node
    parent::Node
    config::Configuration
    level::Int64
    deadlock::Bool
end

function print_node(node::Node, level=0)
    @match node begin
        RootNode(config, _, children) => "0- RootNode  $(config.location.name) - # Children: $(length(children))\nValuation: $(valuation_to_string(config.valuation))"
        DecisionNode(_, decision, config, _, _, children) => ("\t"^level) * "$level- DecisionNode $(config.location.name) - Time: $(round5(config.global_clock)) - Agent: $(decision.first) - " *
                                                                 "Action: $(decision.second) - # Children: $(length(children))\n" *
                                                                 ("\t"^level) * "Valuation: $(valuation_to_string(config.valuation))"
        TriggerNode(_, decision, config, _, _, children) => ("\t"^level) * "$level- TriggerNode $(config.location.name) - Time: $(round5(config.global_clock)) - Agent: $(decision.first) - " *
                                                                "Trigger: $(constraint_to_string(decision.second)) - # Children: $(length(children))\n" * 
                                                                ("\t"^level) * "Valuation: $(valuation_to_string(config.valuation))"
        PropertyNode(_, config, _) => ("\t"^level) * "$level- PropertyNode - $(config.location.name) - Time: $(round5(config.global_clock))\n" * 
                                                                ("\t"^level) * "Valuation: $(valuation_to_string(config.valuation))"
        FinalNode(_, config, _, true) => ("\t"^level) * "$level- Deadlock - $(config.location.name) - Time: $(round5(config.global_clock))\n" *
                                                                ("\t"^level) * "Valuation: $(valuation_to_string(config.valuation))"
        FinalNode(_, config, _, false) => ("\t"^level) * "$level- TerminalNode - $(config.location.name) - Time: $(round5(config.global_clock))\n" *
                                                                ("\t"^level) * "Valuation: $(valuation_to_string(config.valuation))"
    end
end

# TODO: add function documentation
function print_trees(trees::Vector{RootNode}, queries_text::Vector{String}, results::Vector{Bool})::String
    return print_trees([print_tree(game_tree, queries_text[i], results[i]) for (i, game_tree) in enumerate(trees)])
end

function print_trees(trees::Vector{String})::String
    tree_text = ""
    for tree in trees
        tree_text *= tree
        tree_text *= "\n\n\n***************************\n***************************\n***************************\n\n\n"
    end
    return tree_text
end

# TODO: add function documentation
function print_tree(root::Node, level=0)::String
    res = "$(print_node(root, level))\n\n"
    if :children in fieldnames(typeof(root))
        for child in root.children
            res *= "$(print_tree(child, level+1))"
        end
    end
    return res
end

# TODO: add function documentation
function print_tree(root::Node, query_text::String, result::Bool)::String
    res = "$query_text: $result\n$(print_node(root))\n\n"
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
        PropertyNode(_, _, _) => 1
        TriggerNode(_, _, _, _, _, []) => 1
        TriggerNode(_, _, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        DecisionNode(_, _, _, _, _, []) => 1
        DecisionNode(_, _, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        FinalNode(_, _, _, _) => 1
    end
end

# TODO: add function documentation
function depth_of_tree(root::Node)::Int
    @match root begin
        RootNode(_, _, []) => 1
        RootNode(_, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        PropertyNode(_, _, _) => 1
        TriggerNode(_, _, _, _, _, []) => 1
        TriggerNode(_, _, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        DecisionNode(_, _, _, _, _, []) => 1
        DecisionNode(_, _, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        FinalNode(_, _, _, _) => 1
    end
end


function max_time(root::Node)::Float64
    @match root begin
        RootNode(_, _, []) => 0.0
        RootNode(_, _, children) => maximum(max_time(child) for child in children)
        PropertyNode(_, config, _) => round5(config.global_clock)
        TriggerNode(_, _, config, _, _, []) => round5(config.global_clock)
        TriggerNode(_, _, config, _, _, children) => maximum(max_time(child) for child in children)
        DecisionNode(_, _, config, _, _, []) => round5(config.global_clock)
        DecisionNode(_, _, config, _, _, children) => maximum(max_time(child) for child in children)
        FinalNode(_, config, _, _) => round5(config.global_clock)
    end
end