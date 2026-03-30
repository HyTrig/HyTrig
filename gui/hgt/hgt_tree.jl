""""
    HGT Tree

This file contains all definitions for creating the traversable verification tree of Hybrid Games with Triggers for the GUI.

# Types:
- `GUIBranch`: A branch in a traversable GUI tree.
- `GUINode`: A node in a traversable GUI tree.

# Functions:
- `build_gui_tree(root::RootNode)::GUINode`: Build a GUI tree from a game tree.

# Authors:
- Moritz Maas
"""

"""
    GUIBranch

A branch used in the traversable GUI tree.
"""
struct GUIBranch
    reaching_trigger::Union{Nothing, Pair{Agent, Constraint}}
    config::Configuration
    action_nodes::Vector
    property_nodes::Vector{Union{PropertyNode, FinalNode}}
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
    GUINode(node::DecisionNode, parent::Union{GUINode, Nothing})::GUINode

Create a GUINode from the given active node `node` with the parent `parent`.

# Arguments
- `node::DecisionNode`: The active node.
- `parent::Union{GUINode, Nothing}`: The nodes next active parent.
- `branches::Vector{GUIBranch}`: The branches originating from this node.
"""
function GUINode(node::DecisionNode, parent::Union{GUINode, Nothing})::GUINode
    return GUINode(
        parent,
        node.reaching_decision,
        node.config,
        []
    )
end

"""
    GUINode(node::Union{RootNode, FinalNode}, parent::Union{GUINode, Nothing})::GUINode

Create a GUINode from the given root or final node `node` with the parent `parent`.

# Arguments
- `node::Union{RootNode, FinalNode}`: The root or final node.
- `parent::Union{GUINode, Nothing}`: The nodes next active parent.
"""
function GUINode(node::Union{RootNode, FinalNode}, parent::Union{GUINode, Nothing})::GUINode
    return GUINode(
        parent,
        nothing,
        node.config,
        []
    )
end

"""
    GUIBranch(node::RootNode, action_nodes::Vector{GUINode}, property_nodes::Vector{PropertyNode})::GUIBranch

Create a GUIBranch from the given root node `node` with the `property_nodes`.

# Arguments
- `node::RootNode`: The root node.
- `property_nodes::Vector{PropertyNode}`: The branches property nodes.
- `parent::GUINode`: The branches parent node.
"""
function GUIBranch(node::RootNode, action_nodes::Vector{GUINode}, property_nodes::Vector{PropertyNode})::GUIBranch
    return GUIBranch(
        nothing,
        node.config,
        action_nodes,
        []
    )
end

"""
    GUIBranch(node::TriggerNode, property_nodes::Vector{PropertyNode}, parent::GUINode)::GUIBranch

Create a GUIBranch from the given trigger node `node` with the `property_nodes`.

# Arguments
- `node::TriggerNode`: The trigger node.
- `action_nodes::Vector{GUINode}`: The branches active nodes.
- `property_nodes::Vector{PropertyNode}`: The branches property nodes.
"""
function GUIBranch(node::TriggerNode, action_nodes::Vector{GUINode}, property_nodes::Vector{PropertyNode})::GUIBranch
    return GUIBranch(
        node.reaching_trigger,
        node.config,
        action_nodes,
        property_nodes
    )
end

"""
    GUIBranch(node::FinalNode, property_nodes::Vector{PropertyNode})::GUIBranch

Create a GUIBranch from the given final node `node` with the `property_nodes`.

# Arguments
- `node::FinalNode`: The final node.
- `property_nodes::Vector{PropertyNode}`: The branches property nodes.
"""
function GUIBranch(node::FinalNode, property_nodes::Vector{PropertyNode})::GUIBranch
    return GUIBranch(
        nothing,
        node.config,
        [],
        push!(Vector{Union{PropertyNode, FinalNode}}(property_nodes), node)
    )
end

"""
    GUIBranch(property_nodes::Vector{PropertyNode})::GUIBranch

Create a GUIBranch from the given `property_nodes`.

# Arguments
- `property_nodes::Vector{PropertyNode}`: The branches property nodes.
"""
function GUIBranch(property_nodes::Vector{PropertyNode})::GUIBranch
    return GUIBranch(
        nothing,
        property_nodes[end].config,
        [],
        property_nodes
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
    push!(gui_root.branches, GUIBranch(root, [GUINode(root, gui_root)], PropertyNode[]))

    # Recursively add all layers
    append!(gui_root.branches[1].action_nodes[1].branches, _get_next_layer(root, gui_root.branches[1].action_nodes[1]))
    return gui_root
end

function _get_next_layer(last_node::Union{DecisionNode, RootNode}, parent::GUINode)::Vector{GUIBranch}
    branches::Vector{GUIBranch} = GUIBranch[]
    passives::Vector{PropertyNode} = PropertyNode[]

    # Create child branches
    for child in last_node.children
        if isa(child, FinalNode)
            push!(branches, GUIBranch(child, passives))
            break
        elseif isa(child, TriggerNode)
            actives::Vector{GUINode} = GUINode[]
            for c in child.children
                active::GUINode = GUINode(c, parent)
                append!(active.branches, _get_next_layer(c, active))
                push!(actives, active)
            end
            push!(branches, GUIBranch(child, actives, passives))
            empty!(passives)
            continue
        else
            push!(passives, child)
            continue
        end
    end

    if !isempty(passives)
        push!(branches, GUIBranch(passives))
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
