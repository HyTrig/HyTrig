# using Ranges   # Remove this line
include("src/packages.jl")
include("src/parsers/parse_game.jl")
include("src/model_checking/build_and_evaluate.jl")



example = ARGS[1]

t0 = time();

if isfile(example)
    game, termination_conditions, queries, queries_text = parse_game(example)
else 
    error("Example not recognized")
end


##################################

t1 = time();

results, game_tree = evaluate_queries(game, termination_conditions, queries)

t2 = time();

nodes_count, passive_nodes = count_nodes(game_tree), count_passive_nodes(game_tree)
tree_depth = depth_of_tree(game_tree)
game_time = max_time(game_tree)

println("*************************")
println("Nodes = ", nodes_count, " Passive Nodes = ", passive_nodes, " Depth = ", tree_depth, " Max Time = ", game_time)
println("results = ", results)
println("Time to evaluate and build = $(t2 - t1)")
println("*************************")
println("*** For a full view of the game tree, please use hytrig-gui.jl. ***")
println("*************************")

if length(ARGS) > 1 && ARGS[2] == "-save-tree"
    tree_text = print_tree(game_tree)
    io = open("logs/tree.md", "w");                                                                                                                                                                                                                                                                                                                               
    write(io, tree_text);                                                                                                                                                                                                                                                                                                                                                           
    close(io); 
end
