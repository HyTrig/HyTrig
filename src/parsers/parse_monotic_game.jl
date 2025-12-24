using JSON3
include("../game_syntax/mhg/game.jl")
include("../hybrid_atl/termination_conditions.jl")
include("syntax_parsers/parser.jl")

function parse_interval(interval_text::String)::Interval
    left_open = interval_text[1] == "("
    right_open = interval_text[end] == ")"
    content = interval_text[2:end-1]
    numbers = [tryparse(Float64, number) for number in split(content, ',')]
    left = numbers[1]
    right = numbers[2]
    Interval(left, left_open, right, right_open)
end


function parse_mhg_game(json_file::String)
    open(json_file,"r") do f
        json_string = read(json_file, String)
        FileDict = JSON3.read(json_string)
        GameDict = FileDict["Game"]
        agents = Vector{Agent}([Symbol(agent) for agent in GameDict["agents"]])
        agents_names = [string(agent) for agent in GameDict["agents"]]
        actions = Vector{Action}([Symbol(action) for action in GameDict["actions"]])
        initial_valuation::IntervalAssignment = IntervalAssignment()
        if ! isempty(GameDict["initial_valuation"])
            initial_valuation = OrderedDict(first(keys(init)) => parse_interval(first(values(init))) for init in GameDict["initial_valuation"])
        end
        variables = Vector{String}([String(var) for var in keys(initial_valuation)])
        locations = MHG_Location[]
        locations_names = Vector{String}()
        initial_location = nothing
        for loc in GameDict["locations"]
            name = Symbol(loc["name"])
            push!(locations_names, loc["name"])
            invariant_constraint::Constraint = parse(loc["invariant"], Bindings([], [], variables), constraint)
            invariant::RectConstr = constraint_to_rect_constraint(invariant_constraint)
            flow::IntervalAssignment = IntervalAssignment()
            for reassinment in loc["flow"]
                flow[first(keys(reassinment))] = parse_interval(first(values(reassinment)))
            end
            location = MHG_Location(name, invariant, flow)
            if haskey(loc, "initial") && loc["initial"]
                initial_location = location
            end
            push!(locations, location)
        end
        edges = MHG_Edge[]
        for edge in GameDict["edges"]
            name = Symbol(edge["name"])
            start_location = nothing
            target_location = nothing
            start_location_ind = findfirst(loc -> loc.name == Symbol(edge["start_location"]), locations)
            target_location_ind = findfirst(loc -> loc.name == Symbol(edge["target_location"]), locations)
            if start_location_ind === nothing || target_location_ind === nothing
                error("Edge $(name) references non-existent locations:", edge["start_location"], " - ", edge["target_location"])
            else
                start_location = locations[start_location_ind]
                target_location = locations[target_location_ind]
            end
            decisions::Vector{Decision} = Pair{Agent, Action}[Symbol(agent) => Symbol(action) for (agent, action) in edge["decision"]]
            if length(decisions) != 1
                error("Edge $(name) must have exactly one decision (agent-action pair). Found: ", decisions)
            end
            guard_constraint::Constraint = parse(edge["guard"], Bindings([], [], variables), constraint)
            guard::RectConstr = constraint_to_rect_constraint(guard_constraint)
            jump::IntervalAssignment = IntervalAssignment()
            for reassinment in edge["jump"]
                jump[first(keys(reassinment))] = parse_interval(first(values(reassinment)))
            end
            push!(edges, MHG_Edge(name, start_location, target_location, guard, decisions[1], jump))
        end

        game = MHG_Game(locations, initial_location, initial_valuation, agents, actions, edges)

        termination_conditions = Termination_Conditions(
            Float64(FileDict["termination-conditions"]["time-bound"]),
            Int64(FileDict["termination-conditions"]["max-steps"]),
            parse(FileDict["termination-conditions"]["state-formula"], Bindings(agents_names, locations_names, variables), state)
        )
        queries::Vector{Strategy_Formula} = Strategy_Formula[parse(query, Bindings(agents_names, locations_names, variables), strategy) for query in FileDict["queries"]]
        return game, termination_conditions, queries, FileDict["queries"]

    end
end

# game, tc, queries, queries_text = parse_mhg_game("../../examples/monotonic_hybrid_games/2_player_ball_game.json")

# println("********************")
# println(game)
# println("********************")