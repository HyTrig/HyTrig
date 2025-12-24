include("src/packages.jl")
include("src/model_checking/hgt/build_and_evaluate.jl")
include("src/parsers/parse_hgt_game.jl")
include("src/parsers/parse_monotic_game.jl")

using Dates

function READ_USER_FILE()
    try
        game_types = readdir("examples")

        println("Please the type of game you want to verify:")
        for (i, gt) in enumerate(game_types)
            println("\t $i. $gt")
        end
        game_type = tryparse(Int64, readline())

        examples_folder = "examples/$(game_types[game_type])"

        examples = readdir(examples_folder)

        println("Please enter your the relative path to the JSON file or choose the number of one of the examples below:")
        for (i, exmp) in enumerate(examples)
            println("\t $i. $exmp")
        end

        file_name = readline()

        example_number = tryparse(Int64, file_name)
        if example_number !== nothing
            file_name = "$examples_folder/" * examples[example_number]
        end

        if game_type == 1
            game, termination_conditions, queries, queries_text = parse_hgt_game(file_name)
        else
            game, termination_conditions, queries, queries_text = parse_mhg_game(file_name)

            return
        end
        println("\n--- SUCCESS ---")
        println("Content successfully read from \"", file_name, "\".")
        println("---------------")
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
        for (r, result) in enumerate(results)
            print("$(queries_text[r]): ")
            if result
                print("True\n")
            else
                print("False\n")
            end
        end

        println("*************************")
        println("Evaluattion Time = $(t2 - t1)")
        println("*** For a full view of the game tree, please use hytrig-gui.jl. ***")
        println("*************************")


        current_datetime_str = Dates.format(now(), "yyyy-mm-dd_HHMMSS")
        tree_file_name = "logs/tree-1$(current_datetime_str).md"
        println("Would you like to save the outcome tree in $tree_file_name? (y/n)")
        tree_answer = readline()
        if tree_answer == "y"
            tree_text = print_tree(game_tree)
            io = open(tree_file_name, "w");                                                                                                                                                                                                                                                                                                                               
            write(io, tree_text);                                                                                                                                                                                                                                                                                                                                                           
            close(io); 
        end

    catch e
        # 4. Handle exceptions. Check if it's a SystemError and specifically related 
        # to a missing file using the error message.
        if isa(e, SystemError) && occursin("no such file or directory", lowercase(e.msg))
            println("\n!!! FILE NOT FOUND ERROR !!!")
            println("Could not read \"$file_name\".")
            println("Please create this file in the same directory as the script to test the success case.")
            println("!!! ---------------------- !!!")
        else
            # Handle other unexpected errors (e.g., permission issues)
            println("\n!!! UNEXPECTED ERROR OCCURRED !!!")
            showerror(stdout, e)
            println("\n!!! --------------------------- !!!")
        end
    end
end

READ_USER_FILE()