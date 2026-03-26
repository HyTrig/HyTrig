using Pkg

Pkg.activate(".")
Pkg.instantiate()

using Dates

include("src/hytrig.jl")
using .HyTrig

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
            println(zone_to_string(initial_zone(game)))
            for edge in game.initial_location.edges
               println(interval_to_string(edge_time_interval(initial_zone(game), edge))) 
            end
            return
        end
        println("\n--- SUCCESS ---")
        println("Content successfully read from \"", file_name, "\".")
        println("---------------")
        ##################################

        t1 = time();
        results = Bool[]
        trees = RootNode[]
        for query in queries
            if game_type == 1
                result, game_tree = check_query(game, termination_conditions, query)
                push!(trees, game_tree)
                push!(results, result)
            else
                print(initial_zone)
                return
            end
        end

        t2 = time();


        println("*************************")
        for (r, result) in enumerate(results)
            nodes_count = count_nodes(trees[r])
            tree_depth = depth_of_tree(trees[r])
            game_time = max_time(trees[r])
            print("$(queries_text[r]): ")
            if result
                print("True\n")
            else
                print("False\n")
            end
            println("Nodes = ", nodes_count, " Depth = ", tree_depth, " Max Time = ", game_time)
        end

        println("*************************")
        println("Evaluattion Time = $(t2 - t1)")
        println("*** For a full view of the game tree, please use hytrig-gui.jl. ***")
        println("*************************")


        current_datetime_str = Dates.format(now(), "yyyy-mm-dd_HHMMSS")
        example_name = replace(examples[example_number], r".hytrig$"=>"")
        tree_file_name = "logs/$(example_name)-tree-1$(current_datetime_str).md"
        println("Would you like to save the outcome tree in $tree_file_name? (y/n)")
        tree_answer = readline()
        if tree_answer == "y"
            tree_text = print_trees(trees, queries_text, results)
            open(tree_file_name, "w") do f
                write(f, tree_text)
            end
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
            # println("\n!!! UNEXPECTED ERROR OCCURRED !!!")
            # showerror(stdout, e)
            # println("\n!!! --------------------------- !!!")
            throw(e)
        end
    end
end

READ_USER_FILE()
