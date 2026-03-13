"""
    MHG Functions
    
This file contains all functions related to the Monotonic Hybrid Games (MHG) editor in the HyTrig GUI.

# Functions:
- `mhg_name_available(name::QString)::Bool`: Check whether a name is available.
- `mhg_is_formula(text::QString, level::QString)::Bool`: Check whether a formula is valid at a given parse level.
- `mhg_save(path::QString)`: Save the current game to a file.
- `mhg_load(path::QString)::String`: Load a game from a file.
- `mhg_verify()::String`: Verify the current game.

# Authors:
- Moritz Maas
"""


"""
    mhg_name_available(name::QString)::Bool

Check whether a name is available (not used by any action, agent, variable or location).

# Arguments
- `name::QString`: The name to check.
"""
function mhg_name_available(name::QString)::Bool
    return !any(v -> v.name == name, [mhg_action_list; mhg_agent_list; mhg_variable_list; mhg_location_list])
end

"""
    mhg_is_formula(text::QString, level::QString)::Bool

Check whether a formula is valid at a given parse level.

# Arguments
- `text::QString`: The formula as a string.
- `level::QString`: The parse level as a string (`expression`, `constraint`, `state` or `strategy`).
"""
function mhg_is_formula(text::QString, level::QString)::Bool
    bindings::Bindings = Bindings(
        [x.name for x in mhg_agent_list],
        [x.name for x in mhg_location_list],
        [x.name for x in mhg_variable_list]
    )
    level::ParseLevel = eval(Symbol(String(level)))
    try
        if level == expression
            parse(String(text), bindings, level)
        elseif level == constraint
            constraint_to_rect_constraint(
                parse(String(text), bindings, level)
            )
        else
            formula_to_rect_formula(
                parse(String(text), bindings, level)
            )
        end
        return true
    catch
        return false
    end
end

"""
    mhg_save(path::QString)

Save the current game to a file given by `path`.

# Arguments
- `path::QString`: The file path to save to.
"""
function mhg_save(path::QString)
    data::OrderedDict{String, Any} = OrderedDict([
        "game_type" => "MHG",
        "agents" => mhg_agent_list,
        "actions" => mhg_action_list,
        "variables" => mhg_variable_list,
        "locations" => [
            Dict(
                "name" => loc.name,
                "initial" => loc.initial,
                "invariant" => loc.invariant,
                "flow" => [
                    Dict(
                        "variable" => loc.flow[i].variable,
                        "lower_open" => loc.flow[i].lower_open,
                        "upper_open" => loc.flow[i].upper_open,
                        "lower" => loc.flow[i].lower,
                        "upper" => loc.flow[i].upper,
                    ) for i in 1:length(loc.flow)
                ],
            ) for loc in mhg_location_list
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
                        "is_none" => edge.jump[i].is_none,
                        "lower_open" => edge.jump[i].lower_open,
                        "upper_open" => edge.jump[i].upper_open,
                        "lower" => edge.jump[i].lower,
                        "upper" => edge.jump[i].upper,
                    ) for i in 1:length(edge.jump)
                ],
            ) for edge in mhg_edge_list
        ],
        "queries" => mhg_query_list,
        "config" => Dict([
            "max_steps" => mhg_models["max_steps"],
            "time_bound" => mhg_models["time_bound"],
            "state_formula" => mhg_models["state_formula"],
        ]),
    ])

    open(replace(String(path), r"^(file:\/{2})" => ""), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

"""
    mhg_load(path::QString)::String

Load a game from a file given by `path`.

# Arguments
- `path::QString`: The file path to load from.
"""
function mhg_load(path::QString)::String
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
        if data["game_type"] != "MHG"
            return "not a Monotonic Hybrid Game"
        end
        load_elements("agents", QMHGAgent, mhg_agent_list)
        load_elements("actions", QMHGAction, mhg_action_list)
        load_elements("variables", QMHGVariable, mhg_variable_list)
        empty!(mhg_location_list)
        for loc in data["locations"]
            flow_list::Vector{QMHGFlow} = QMHGFlow[]
            for flow in loc["flow"]
                push!(flow_list, StructTypes.constructfrom(QMHGFlow, flow))
            end
            push!(mhg_location_list, QMHGLocation(loc["name"], loc["initial"], loc["invariant"], JuliaItemModel(flow_list)))
        end
        empty!(mhg_edge_list)
        for edge in data["edges"]
            jump_list::Vector{QMHGJump} = QMHGJump[]
            for jump in edge["jump"]
                push!(jump_list, StructTypes.constructfrom(QMHGJump, jump))
            end
            push!(mhg_edge_list, QMHGEdge(edge["source"], edge["target"], edge["guard"], edge["agent"], edge["action"], JuliaItemModel(jump_list)))
        end
        load_elements("queries", QMHGQuery, mhg_query_list)

        mhg_models["max_steps"] = data["config"]["max_steps"]
        mhg_models["time_bound"] = data["config"]["time_bound"]
        mhg_models["state_formula"] = data["config"]["state_formula"]
    catch e
        return "invalid HYTRIG file for Monotonic Hybrid Games: Missing key $(e.key)"
    end

    return ""
end

"""
    mhg_verify()::String

Verify the current game.
"""
function mhg_verify()::String
    # TODO: Implement verification for MHGs
    return "verification not yet implemented for Monotonic Hybrid Games"
end
