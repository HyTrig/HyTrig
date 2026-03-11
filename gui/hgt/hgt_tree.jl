""""
    HGT Tree

This file contains all definitions for creating the traversable verification tree of Hybrid Games with Triggers for the GUI.

# Types:
- `GUIBranch`: A branch in a traversable GUI tree.
- `GUINode`: A node in a traversable GUI tree.

# Functions:
- `build_gui_tree(root::Union{ActionNode, RootNode})::GUINode`: Build a GUI tree from a game tree.

# Authors:
- Moritz Maas
"""

"""
    GUIBranch

A branch used in the traversable GUI tree.
"""
struct GUIBranch
    reaching_decision::Union{Pair{Agent, Action}, Nothing}
    reaching_trigger::Union{Constraint, Nothing}
    config::Configuration
    active_nodes::Vector
    passive_nodes::Vector{PassiveNode}
end

"""
    GUINode

A node used in the traversable GUI tree.
"""
struct GUINode
    parent::Union{GUINode, Nothing}
    reaching_decision::Union{Pair{Agent, Action}, Nothing}
    config::Configuration
    branches::Vector{GUIBranch}
end

"""
    GUINode(node::ActionNode, parent::Union{GUINode, Nothing})::GUINode

Create a GUINode from the given active node `node` with the parent `parent`.

# Arguments
- `node::ActionNode`: The active node.
- `parent::Union{GUINode, Nothing}`: The nodes next active parent.
"""
function GUINode(node::ActionNode, parent::Union{GUINode, Nothing})::GUINode
    return GUINode(
        parent,
        node.reaching_decision,
        node.config,
        []
    )
end

"""
    GUINode(node::Union{RootNode, EndNode}, parent::Union{GUINode, Nothing})::GUINode

Create a GUINode from the given root or end node `node` with the parent `parent`.

# Arguments
- `node::Union{RootNode, EndNode}`: The root or end node.
- `parent::Union{GUINode, Nothing}`: The nodes next active parent.
"""
function GUINode(node::Union{RootNode, EndNode}, parent::Union{GUINode, Nothing})::GUINode
    return GUINode(
        parent,
        nothing,
        node.config,
        []
    )
end


"""
    GUIBranch(node::ActionNode, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch

Create a GUIBranch from the given active node `node` with the `active_nodes` and `passive_nodes`.

# Arguments
- `node::ActionNode`: The active node.
- `active_nodes::Vector{GUINode}`: The branches active nodes.
- `passive_nodes::Vector{PassiveNode}`: The branches passive nodes.
"""
function GUIBranch(node::ActionNode, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch
    return GUIBranch(
        node.reaching_decision,
        node.reaching_trigger,
        node.config,
        active_nodes,
        passive_nodes
    )
end

"""
    GUIBranch(node::Union{RootNode, EndNode}, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch

Create a GUIBranch from the given root or end node `node` with the `active_nodes` and `passive_nodes`.

# Arguments
- `node::Union{RootNode, EndNode}`: The root or end node.
- `active_nodes::Vector{GUINode}`: The branches active nodes.
- `passive_nodes::Vector{PassiveNode}`: The branches passive nodes.
"""
function GUIBranch(node::Union{RootNode, EndNode}, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch
    return GUIBranch(
        nothing,
        nothing,
        node.config,
        active_nodes,
        passive_nodes
    )
end

"""
    build_gui_tree(root::RootNode)::GUINode

Recursively build the GUI tree from a game tree rooted in `root`.

# Arguments
- `root::RootNode`: The game trees root.
"""
function build_gui_tree(root::RootNode)::GUINode
    # Create root node with branches
    gui_root = GUINode(root, nothing)
    push!(gui_root.branches, GUIBranch(root, [GUINode(root, gui_root)], PassiveNode[]))

    # Recursively add all layers
    append!(gui_root.branches[1].active_nodes[1].branches, _get_next_layer(root, gui_root.branches[1].active_nodes[1]))
    return gui_root
end

function _get_next_layer(last_node::ActionNode, parent::GUINode)::Vector{GUIBranch}
    branches::Vector{GUIBranch} = []
    last_trigger_time::Float64 = last_node.config.global_clock

    # Create child branches
    for child in last_node.children
        current_node::Node = child
        
        # Collect passive nodes until an active or end node is reached
        passives::Vector{PassiveNode} = []
        while !(current_node isa ActionNode || current_node isa EndNode)
            if current_node.config.global_clock >= last_trigger_time
                push!(passives, current_node)
            end
            if length(current_node.children) != 1 && current_node.children[1] isa PassiveNode
                throw(ArgumentError("Tree is not valid."))
            end
            current_node = current_node.children[1]
        end

        current_node = current_node.parent
        
        # Create active nodes for the current layer
        actives::Vector{GUINode} = []
        for active in current_node.children
            gui_node = GUINode(active, parent)
            if !(active isa EndNode)
                append!(gui_node.branches, _get_next_layer(active, gui_node))
            end
            push!(actives, gui_node)
        end

        current_node = current_node.children[1]
        last_trigger_time = current_node.config.global_clock
        push!(branches, GUIBranch(current_node, actives, passives))
    end
    return branches
end

function _get_valuation_string(valuation::Valuation)::String
    str = ""
    for (i, val) in enumerate(keys(valuation))
        str *= "$(string(val)) = $(trunc(valuation[val], digits=5))"
        if i != length(keys(valuation))
            str *= ",\n"
        end
    end
    return "$str"
end
