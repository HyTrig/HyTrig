include("../packages.jl")

using Dates
using JSON3
using QML

include("../parsers/parser.jl")

mutable struct QTrigger
    name::String
end

mutable struct QAgent
    name::String
    triggers::JuliaItemModel
end

function QAgent(name, triggers::AbstractArray)
  return QAgent(name, JuliaItemModel([QTrigger(QML.value(t)["name"]) for t in triggers]))
end

function settriggers!(agent_model, triggers, row, col)
    agent_model[row].triggers = JuliaItemModel([QTrigger(QML.value(t)["name"]) for t in triggers])
end

mutable struct QAction
    name::String
end

mutable struct QVariable
    name::String
    value::String
end

mutable struct QLocation
    name::String
    inv::String
    initial::Bool
end

mutable struct QFlow
    loc::String
    var::String
    flow::String
end

mutable struct QEdge
    name::String
    source::String
    target::String
    guard::String
    agent::String
    action::String
end

mutable struct QQuery
    name::String
end

agent_list::Vector{QAgent} = []
agent_model::JuliaItemModel = JuliaItemModel(agent_list)
setsetter!(agent_model, settriggers!, roleindex(agent_model, "triggers"))

action_list::Vector{QAction} = []
variable_list::Vector{QVariable} = []
location_list::Vector{QLocation} = []
edge_list::Vector{QEdge} = []
query_list::Vector{QQuery} = []
flow_list::Vector{QFlow} = []

function has_name(name)::Bool
    name = String(name)

    agents = Set(collect(x.name for x in agent_list))
    actions = Set(collect(x.name for x in action_list))
    locations = Set(collect(x.name for x in location_list))
    variables = Set(collect(x.name for x in variable_list))
    edges = Set(collect(x.name for x in edge_list))

    if name in union(agents, actions, locations, variables, edges)
        return true
    end
    return false
end

function is_valid_formula(formula, level)
    formula = String(formula)
    level = eval(Symbol(level))
    if !(level isa ParseLevel)
        return false
    end

    agents = Set(collect(x.name for x in agent_list))
    locations = Set(collect(x.name for x in location_list))
    variables = Set(collect(x.name for x in variable_list))

    try
        parse(formula, Bindings(agents, locations, variables), level)
        return true
    catch
        return false
    end
end

function save_to_json()
    data = Dict(
        "Game" => Dict(
            "name" => "save$(now())",
            "locations" => [_get_location_json(loc) for loc in location_list],
            "initial_valuation" => Dict(variable.name => variable.value for variable in variable_list),
            "agents" => [agent.name for agent in agent_list],
            "triggers" => Dict(
                agent.name => [trigger.name for trigger in values(agent.triggers)[]] for agent in agent_list
            ),
            "actions" => [action.name for action in action_list],
            "edges" => "" # TODO 
        ),
        "termination-conditions" => "", # TODO
        "queries" => [query.name for query in query_list]
    )
    open(joinpath("data", "save$(now()).json"), "w") do f
        JSON3.pretty(f, JSON3.write(data))
    end
end

function _get_location_json(loc::QLocation)
    return Dict(
        "name" => loc.name,
        "invariant" => loc.inv,
        "flow" => Dict(
            flow.var => flow.flow for flow in flow_list if flow.loc == loc.name
        ),
        "initial" => loc.initial
    )
end

@qmlfunction has_name is_valid_formula save_to_json

qml_file = joinpath(dirname(@__FILE__), "qml", "gui.qml")

loadqml(
    qml_file,
    agent_model = agent_model,
    action_model = JuliaItemModel(action_list),
    variable_model = JuliaItemModel(variable_list),
    location_model = JuliaItemModel(location_list),
    edge_model = JuliaItemModel(edge_list),
    query_model = JuliaItemModel(query_list),
    flow_model = JuliaItemModel(flow_list)
)

exec()
