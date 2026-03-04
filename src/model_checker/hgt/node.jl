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

export Node, RootNode, TriggerNode, PassiveNode, DiscreteTransitionNode, EndNode
export print_tree, count_nodes, depth_of_tree, max_time
export sort_children_by_clock!, sort_children_by_clock_and_agent

abstract type Node
end

struct RootNode <: Node
    config::Configuration
    level::Int32
    children::Vector{Node}
end

struct DiscreteTransitionNode <: Node
    parent::Node
    reaching_decision::Pair{Agent, Action}
    reaching_trigger::Constraint
    config::Configuration
    level::Int32
    children::Vector{Node}
end

struct TriggerNode <: Node
    parent::Node
    trigger::Pair{Agent, Constraint}
    config::Configuration
    level::Int32
    children::Vector{Node}
end

struct PassiveNode <: Node
    parent::Node
    config::Configuration
    level::Int32
end

struct EndNode <: Node
    parent::Node
    config::Configuration
    level::Int32
end

function print_tree(root::Node)
    res = ""
    @match root begin
        RootNode(_, _, children) =>
            begin
                res *= "\nRoot  $(root.config.location.name)\nValuation: $(root.config.valuation)\nChildren: $(length(children))"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        PassiveNode(_, _, level) =>
            begin
                if isnothing(decision)
                    res *= "\n$level- Passive - Location: $(root.config.location.name)\nValuation: $(root.config.valuation), - Time: $(root.config.global_clock)"
                res *= "\n--------------\n"
                else
                    res *= "\n$level- Passive - Agent: $(decision.first) - Trigger: $(constraint_to_string(decision.second)) - Location: $(root.config.location.name)\nValuation: $(round5(root.config.valuation)), - Time: $(round5(root.config.global_clock))\nChildren: $(length(children))"
                res *= "\n--------------\n"
                end
                for child in children
                    res *=print_tree(child)
                end
            end
        DiscreteTransitionNode(_, decision, trigger, _, level, children) =>
            begin
                res *= "\n$level- Active - Agent: $(decision.first) - Action: $(decision.second) / $(constraint_to_string(trigger)) - Location: $(root.config.location.name)\nValuation: $(round5(root.config.valuation)), - Time: $(round5(root.config.global_clock))\nChildren: $(length(children))"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        TriggerNode(_, trigger, _, level, children) =>
            begin
                res *= "\n$level- Active - Agent: $(decision.first) - Action: $(decision.second) / $(constraint_to_string(trigger)) - Location: $(root.config.location.name)\nValuation: $(round5(root.config.valuation)), - Time: $(round5(root.config.global_clock))\nChildren: $(length(children))"
                res *= "\n--------------\n"
                for child in children
                    res *= print_tree(child)
                end
            end
        EndNode(_, _, level) =>
            begin
                res *= "\n$level- End - Location: $(root.config.location.name)\nValuation: $(root.config.valuation), - Time: $(root.config.global_clock)"
                res *= "\n--------------\n"
                for child in children
                    res *=print_tree(child)
                end
            end
    end
    return res
end

function count_nodes(root::Node)::Int
    @match root begin
        RootNode(_, _, []) => 1
        RootNode(_, _, children) => 1 + sum(count_nodes(child) for child in children)
        PassiveNode(_, _, _) => 1
        TriggerNode(_, _, _, _, []) => 1
        TriggerNode(_, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        DiscreteTransitionNode(_, _, _, _, _, []) => 1
        DiscreteTransitionNode(_, _, _, _, _, children) => 1 + sum(count_nodes(child) for child in children)
        EndNode(_, _, _) => 1
    end
end

function depth_of_tree(root::Node)::Int
    @match root begin
        RootNode(_, _, []) => 1
        RootNode(_, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        PassiveNode(_, _, _) => 1
        TriggerNode(_, _, _, _, []) => 1
        TriggerNode(_, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        DiscreteTransitionNode(_, _, _, _, _, []) => 1
        DiscreteTransitionNode(_, _, _, _, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        EndNode(_, _, _) => 1
    end
end


function max_time(root::Node)::Float64
    @match root begin
        RootNode(_, _, []) => 0.0
        RootNode(_, _, children) => 1 + maximum(depth_of_tree(child) for child in children)
        PassiveNode(_, _, _) => round5(root.config.global_clock)
        TriggerNode(_, _, _, _, []) => round5(root.config.global_clock)
        TriggerNode(_, _, _, _, children) => maximum(max_time(child) for child in children)
        DiscreteTransitionNode(_, _, _, _, _, []) => round5(root.config.global_clock)
        DiscreteTransitionNode(_, _, _, _, _, children) => maximum(max_time(child) for child in children)
        EndNode(_, _, _) => round5(root.config.global_clock)
    end
end

function sort_children_by_clock!(root::Node)
    # sorts children by global clock, and if two children have the same clock, the one with the agent's decision comes last
    sort!(root.children, by = child -> child.config.global_clock)
end

function sort_children_by_clock_and_agent(root::Node, agents::Vector{Agent})
    # sorts children by global clock, and if two children have the same clock, the one with the agent's decision comes last
    sort(root.children, by = child -> (round5(child.config.global_clock), child.reaching_decision.first in agents))
end
