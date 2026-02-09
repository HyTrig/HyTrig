"""TODO: write docs"""

export parse_hgt_game

function parse_hgt_game(hytrig_file::String)
    data = open(hytrig_file,"r") do f
        JSON3.read(f)
    end
    agents = Vector{Agent}([Agent(agent["name"]) for agent in data["agents"]])
    actions = Vector{Action}([Action(action["name"]) for action in data["actions"]])
    initial_valuation::Valuation = OrderedDict{Variable, Float64}(
        Variable(var["name"]) => Base.parse(Float64, var["expression"]) for var in data["variables"]
    )
    bindings = Bindings(
        [string(agent) for agent in agents],
        [],
        [string(var["name"]) for var in data["variables"]],
    )
    locations = Vector{Location}([
        Location(
            Symbol(loc["name"]),
            parse(loc["invariant"], bindings, constraint),
            ReAssignment(
                Variable(flow["variable"]) => parse(flow["expression"], bindings, expression) for flow in loc["flow"]
            )
        ) for loc in data["locations"]
    ])
    initial_location_name = data["locations"][findfirst(loc -> loc["initial"], data["locations"])]["name"]
    initial_location = locations[findfirst(loc -> loc.name == Symbol(initial_location_name), locations)]
    bindings = Bindings(
        [string(agent) for agent in agents],
        [string(loc.name) for loc in locations],
        [string(var["name"]) for var in data["variables"]],
    )
    edges = Vector{Edge}([
        Edge(
            Symbol(i),
            locations[findfirst(loc -> loc.name == Symbol(edge["source"]), locations)],
            locations[findfirst(loc -> loc.name == Symbol(edge["target"]), locations)],
            parse(edge["guard"], bindings, constraint),
            Decision(
                Agent(edge["agent"]),
                Action(edge["action"])
            ),
            ReAssignment(
                Variable(jump["variable"]) => parse(jump["expression"], bindings, expression) for jump in edge["jump"]
            )
        ) for (i, edge) in enumerate(data["edges"])
    ])
    triggers = Dict{Agent, Vector{Constraint}}()
    for trigger in data["triggers"]
        agent = Agent(trigger["agent"])
        if !haskey(triggers, agent)
            triggers[agent] = Vector{Constraint}()
        end
        push!(triggers[agent], parse(trigger["trigger"], bindings, constraint))
    end
    game = Game(
        locations,
        initial_location,
        initial_valuation,
        agents,
        actions,
        edges,
        triggers,
        true
    )
    termination_conditions = Termination_Conditions(
        Base.parse(Float64, data["config"]["time_bound"]),
        Base.parse(Int64, data["config"]["max_steps"]),
        parse(data["config"]["state_formula"], bindings, state)
    )
    queries = Strategy_Formula[
        parse(query["formula"], bindings, strategy) for query in data["queries"]
    ]
    return game, termination_conditions, queries, [query["formula"] for query in data["queries"]]
end
