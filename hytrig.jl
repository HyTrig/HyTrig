examples = ["3_players_1_ball", "4_player_square", "bouncing_ball", "player_in_middle", "volleyball", "volleyball_2-players_3-points_1-trigger", "volleyball_3-points_1-trigger"]

println("Please enter your the relative path to the JSON file or choose the number of one of the examples below:")

for (i, exmp) in enumerate(examples)
    println("\t $i. $exmp")
end

file = readline()

try
    include("src/packages.jl")
    include("src/parsers/parse_game.jl")
    include("src/model_checking/build_and_evaluate.jl")

    t0 = time();

    example_number = tryparse(Int64, file)
    if example_number !== nothing
        game, termination_conditions, queries, queries_text = parse_game("examples/" * examples[example_number] * ".json")
    else 
        game, termination_conditions, queries, queries_text = parse_game(file)
    end


    ##################################

    t1 = time();

    results, game_tree = evaluate_queries(game, termination_conditions, queries)

    t2 = time();

    nodes_count, passive_nodes = count_nodes(game_tree), count_passive_nodes(game_tree)
    tree_depth = depth_of_tree(game_tree)

    println("*************************")
    println("Nodes = ", nodes_count, " Passive Nodes = ", passive_nodes, " Depth = ", tree_depth)
    println("results = ", results)
    println("Time to evaluate and build = $(t2 - t1)")
    println("*************************")
    println("*** For a full view of the game tree, please use hytrig-gui.jl. ***")
    println("*************************")


    println("Would you like to save the outcome tree in logs/tree.md? (Y/N)")
    tree_answer = readline()
    if tree_answer == "Y"
        tree_text = print_tree(game_tree)
        io = open("logs/tree.md", "w");                                                                                                                                                                                                                                                                                                                               
        write(io, tree_text);                                                                                                                                                                                                                                                                                                                                                           
        close(io); 
    end
catch e
    println("Could not read the file $file")
end
