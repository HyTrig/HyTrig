"""
    HGT Functions
    
This file contains all functions related to the Hybrid Games with Triggers (HGT) editor in the HyTrig GUI.

# Functions:
- `hgt_name_available(name::QString)::Bool`: Check whether a name is available.
- `hgt_is_formula(text::QString, level::QString)::Bool`: Check whether a formula is valid at a given parse level.
- `hgt_save(path::QString)`: Save the current game to a file.
- `hgt_load(path::QString)::String`: Load a game from a file.
- `hgt_verify()::String`: Verify the current game.
- `hgt_up_tree()::Bool`: Set the branch model to the current nodes parent layer.
- `hgt_down_tree(i::Int32, j::Int32)::Bool`: Set the branch model to the child layer of child `j` of branch `i`.

# Authors:
- Moritz Maas
"""

"""
    hgt_name_available(name::QString)::Bool

Check whether a name is available (not used by any action, agent, variable or location).

# Arguments
- `name::QString`: The name to check.
"""
function hgt_name_available(name::QString)::Bool
    return !any(v -> v.name == name, [hgt_action_list; hgt_agent_list; hgt_variable_list; hgt_location_list])
end

"""
    hgt_is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: The formula as a string.
- `level::QString`: The parse level as a string (`expression`, `constraint`, `state` or `strategy`).
"""
function hgt_is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in hgt_agent_list],
        [x.name for x in hgt_location_list],
        [x.name for x in hgt_variable_list]
    )
    try
        parse(String(text), bindings, eval(Symbol(String(level))))
        return true
    catch
        return false
    end
end

"""
    hgt_save(path::QString)

Save the current game to a file given by `path`.

# Arguments
- `path::QString`: The file path to save to.
"""
function hgt_save(path::QString)
    data::OrderedDict{String, Any} = OrderedDict([
        "game_type" => "HGT",
        "agents" => hgt_agent_list,
        "actions" => hgt_action_list,
        "variables" => hgt_variable_list,
        "triggers" => hgt_trigger_list,
        "locations" => [
            Dict(
                "name" => loc.name,
                "initial" => loc.initial,
                "invariant" => loc.invariant,
                "flow" => [
                    Dict(
                        "variable" => loc.flow[i].variable,
                        "expression" => loc.flow[i].expression,
                    ) for i in 1:length(loc.flow)
                ],
            ) for loc in hgt_location_list
        ],
        "edges" => [
            Dict(
                "source" => edge.source,
                "target" => edge.target,
                "guard" => edge.guard,
                "agent" => edge.agent,
                "action" => edge.action,
                "jump" => [
                    Dict(
                        "variable" => edge.jump[i].variable,
                        "expression" => edge.jump[i].expression,
                    ) for i in 1:length(edge.jump)
                ],
            ) for edge in hgt_edge_list
        ],
        "queries" => hgt_query_list,
        "config" => Dict([
            "max_steps" => hgt_models["max_steps"],
            "time_bound" => hgt_models["time_bound"],
            "state_formula" => hgt_models["state_formula"],
        ]),
    ])

    open(replace(String(path), r"^(file:\/{2})" => ""), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

"""
    hgt_load(path::QString)::String

Load a game from a file given by `path`.

# Arguments
- `path::QString`: The file path to load from.
"""
function hgt_load(path::QString)::String
    function load_elements(name::String, type::Type, list::Vector)
        empty!(list)
        for element in data[name]
            push!(list, StructTypes.constructfrom(type, element))
        end
    end

    data = Dict{String, Any}()

    try
        data = open(replace(String(path), r"^(file:\/{2})" => ""), "r") do f
            JSON3.read(f)
        end
    catch e
        return String(strip(e.msg, ['\n', '\r', ' ']))
    end

    try
        if data["game_type"] != "HGT"
            return "not a Hybrid Game with Triggers"
        end
        load_elements("agents", QHGTAgent, hgt_agent_list)
        load_elements("actions", QHGTAction, hgt_action_list)
        load_elements("variables", QHGTVariable, hgt_variable_list)
        load_elements("triggers", QHGTTrigger, hgt_trigger_list)
        empty!(hgt_location_list)
        for loc in data["locations"]
            flow_list::Vector{QHGTFlow} = Vector{QHGTFlow}()
            for flow in loc["flow"]
                push!(flow_list, StructTypes.constructfrom(QHGTFlow, flow))
            end
            push!(hgt_location_list, QHGTLocation(loc["name"], loc["initial"], loc["invariant"], JuliaItemModel(flow_list)))
        end
        empty!(hgt_edge_list)
        for edge in data["edges"]
            jump_list::Vector{QHGTJump} = Vector{QHGTJump}()
            for jump in edge["jump"]
                push!(jump_list, StructTypes.constructfrom(QHGTJump, jump))
            end
            push!(hgt_edge_list, QHGTEdge(edge["source"], edge["target"], edge["guard"], edge["agent"], edge["action"], JuliaItemModel(jump_list)))
        end
        empty!(hgt_query_list)
        for query in data["queries"]
            push!(hgt_query_list, QHGTQuery(query["formula"], false))
        end

        hgt_models["max_steps"] = data["config"]["max_steps"]
        hgt_models["time_bound"] = data["config"]["time_bound"]
        hgt_models["state_formula"] = data["config"]["state_formula"]
    catch e
        return "invalid HYTRIG file for Hybrid Games with Triggers: Missing key $(e.key)"
    end

    return ""
end

"""
    hgt_verify()::String

Verify the current game.
"""
function hgt_verify()::String
    global hgt_tree
    bindings::Bindings = Bindings(
        [x.name for x in hgt_agent_list],
        [x.name for x in hgt_location_list],
        [x.name for x in hgt_variable_list]
    )
    results::Vector{Bool} = []
    try
        locations = Vector{HGT_Location}([
            HGT_Location(
                Symbol(x.name),
                parse(x.invariant, bindings, constraint),
                Assignment(
                    Variable(x.flow[i].variable) => parse(x.flow[i].expression, bindings, expression) for i in 1:length(x.flow)
                )
            ) for x in hgt_location_list
        ])
        initial_valuation = Valuation(
            Variable(x.name) => Base.parse(Float64, x.expression) for x in hgt_variable_list
        )
        edges = Vector{HGT_Edge}([
            HGT_Edge(
                Symbol(i),
                locations[findfirst(loc -> loc.name == Symbol(edge.source), locations)],
                locations[findfirst(loc -> loc.name == Symbol(edge.target), locations)],
                parse(edge.guard, bindings, constraint),
                Decision(
                    Agent(edge.agent),
                    Action(edge.action)
                ),
                Assignment(
                    Variable(edge.jump[j].variable) => parse(edge.jump[j].expression, bindings, expression) for j in 1:length(edge.jump)
                )
            ) for (i, edge) in enumerate(hgt_edge_list)
        ])  
        triggers = Dict{Agent, Vector{Constraint}}()
        for x in hgt_trigger_list
            agent = Agent(x.agent)
            if !haskey(triggers, agent)
                triggers[agent] = Vector{Constraint}()
            end
            push!(triggers[agent], parse(x.trigger, bindings, constraint))
        end    
        game = HGT_Game(
            locations,
            locations[findfirst(loc -> loc.initial, hgt_location_list)],
            initial_valuation,
            [Agent(x.name) for x in hgt_agent_list],
            [Action(x.name) for x in hgt_action_list],
            edges,
            triggers
        )

        results, hgt_tree = evaluate_queries(
            game,
            Termination_Conditions(
                Base.parse(Float64, hgt_models["time_bound"]),
                Base.parse(Int64, hgt_models["max_steps"]),
                parse(hgt_models["state_formula"], bindings, state)
            ),
            Vector{Strategy_Formula}([parse(query.formula, bindings, strategy) for query in hgt_query_list])
        )
    catch e
        if e isa ParseError
            return "parse error: $(e.msg)"
        end
        throw(e)
    end

    empty!(hgt_branch_list)

    if !isnothing(hgt_tree)
        hgt_tree = build_gui_tree(hgt_tree)
        push!(hgt_branch_list, QHGTBranch(hgt_tree.branches[1]))
    end

    for (i, query) in enumerate(hgt_query_list)
        query.verified = results[i]
    end

    return ""
end

"""
    hgt_up_tree()::Bool

Set the branch model to the current nodes parent layer.
"""
function hgt_up_tree()::Bool
    global hgt_tree
    if isnothing(hgt_tree) || isnothing(hgt_tree.parent)
        return false
    end

    empty!(hgt_branch_list)

    hgt_tree = hgt_tree.parent

    for branch in hgt_tree.branches
        push!(hgt_branch_list, QHGTBranch(branch))
    end
    return true
end

"""
    hgt_down_tree(i::Int32, j::Int32)::Bool

Set the branch model to the child layer of child `j` of branch `i`.

# Arguments:
- `i::Int32`: The index of the branch to go down to.
- `j::Int32`: The index of the child to go down to.
"""
function hgt_down_tree(i::Int32, j::Int32)::Bool
    global hgt_tree
    if isempty(hgt_branch_list) || isnothing(hgt_tree)
        return false
    end

    i = Int(i) + 1
    j = Int(j) + 1

    if 0 < i <= length(hgt_tree.branches) && 0 < j <= length(hgt_tree.branches[i].active_nodes)
        empty!(hgt_branch_list)
        hgt_tree = hgt_tree.branches[i].active_nodes[j]
        for branch in hgt_tree.branches
            push!(hgt_branch_list, QHGTBranch(branch))
        end
        return true
    else
        return false
    end
end
