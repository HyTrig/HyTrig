""""
    GUI tree

This file contains all definitions for creating the traversable game tree for the GUI.

# Types:
- `GUINode`: a node in a traversable GUI tree

# Functions:
- `build_gui_tree(root::Union{ActiveNode, RootNode})::GUINode`: build a GUI tree from a game tree
- `up_tree()::Bool`: ascend a layer in the GUI tree
- `down_tree(i)::Bool`: descend a layer in the GUI tree

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
    GUINode(node::ActiveNode, parent::Union{GUINode, Nothing})::GUINode

Create a GUINode from the given active node `node` with the parent `parent`.
# Arguments
- `node::ActiveNode`: the active node
- `parent::Union{GUINode, Nothing}`: the nodes next active parent
"""
function GUINode(node::ActiveNode, parent::Union{GUINode, Nothing})::GUINode
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
- `node::Union{RootNode, EndNode}`: the root or end node
- `parent::Union{GUINode, Nothing}`: the nodes next active parent
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
    GUIBranch(node::ActiveNode, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch

Create a GUIBranch from the given active node `node` with the `active_nodes` and `passive_nodes`.
# Arguments
- `node::ActiveNode`: the active node
- `active_nodes::Vector{GUINode}`: the branches active nodes
- `passive_nodes::Vector{PassiveNode}`: the branches passive nodes
"""
function GUIBranch(node::ActiveNode, active_nodes::Vector{GUINode}, passive_nodes::Vector{PassiveNode})::GUIBranch
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
- `node::Union{RootNode, EndNode}`: the root or end node
- `active_nodes::Vector{GUINode}`: the branches active nodes
- `passive_nodes::Vector{PassiveNode}`: the branches passive nodes
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

global game_tree::Union{GUINode, Node, Nothing}

"""
    build_gui_tree(root::Union{ActiveNode, RootNode})::GUINode

Recursively build the GUI tree from a game tree rooted in `root`.

# Arguments
- `root::Union{ActiveNode, RootNode}`: the game trees root
"""
function build_gui_tree(root::Union{ActiveNode, RootNode})::GUINode
    gui_root = GUINode(root, nothing)
    push!(gui_root.branches, GUIBranch(root, [GUINode(root, gui_root)], Vector{PassiveNode}()))
    append!(gui_root.branches[1].active_nodes[1].branches, _get_next_layer(root, gui_root.branches[1].active_nodes[1]))
    return gui_root
end

"""
    up_tree()::Bool

Set the branch model to the current nodes parent layer.
"""
function up_tree()::Bool
    global game_tree
    if isnothing(game_tree) || isnothing(game_tree.parent)
        return false
    end

    empty!(branch_list)

    game_tree = game_tree.parent

    for branch in game_tree.branches
        push!(branch_list, QBranch(branch))
    end
    return true
end

"""
    down_tree(i, j)::Bool

Set the branch model to the child layer of child `j` of branch `i`.
"""
function down_tree(i, j)::Bool
    global game_tree
    if isempty(branch_list) || isnothing(game_tree)
        return false
    end

    i = Int(i)
    j = Int(j)

    if 0 < i <= length(game_tree.branches) && 0 < j <= length(game_tree.branches[i].active_nodes)
        empty!(branch_list)
        game_tree = game_tree.branches[i].active_nodes[j]
        for branch in game_tree.branches
            push!(branch_list, QBranch(branch))
        end
        return true
    else
        return false
    end
end

function _get_next_layer(node::Union{ActiveNode, RootNode}, parent::GUINode)::Vector{GUIBranch}
    branches::Vector{GUIBranch} = []
    for child in node.children
        passives::Vector{PassiveNode} = []
        current_node::Node = child
        
        while !(current_node isa ActiveNode || current_node isa EndNode)
            push!(passives, current_node)
            if length(current_node.children) != 1 && current_node.children[1] isa PassiveNode
                throw(ArgumentError("Tree is not valid."))
            end
            current_node = current_node.children[1]
        end

        current_node = current_node.parent
        actives::Vector{GUINode} = []
        for active in current_node.children
            gui_node = GUINode(active, parent)
            if !(active isa EndNode)
                append!(gui_node.branches, _get_next_layer(active, gui_node))
            end
            push!(actives, gui_node)
        end
        current_node = current_node.children[1]
        push!(branches, GUIBranch(current_node, actives, passives))
    end
    return branches
end
