"""
    HyTrig Command-Line Interface

Interactive command-line front-end for the HyTrig model checker. It lets the user
pick a Hybrid Game with Triggers (HGT) description in JSON — either by browsing the
bundled `examples/` directory or by typing an arbitrary file path — runs every query
declared in that file, and optionally writes the resulting evaluation trees to a
Markdown log.

Run with:

    julia hytrig_cli.jl
"""

using Pkg

Pkg.activate(@__DIR__)
Pkg.instantiate()

using Dates

include("src/hgtmc.jl")
using .HgtMc

# --------------------------------------------------------------------------- #
# Configuration
# --------------------------------------------------------------------------- #

"Root directory that holds the bundled example games."
const EXAMPLES_DIR = joinpath(@__DIR__, "examples")

"Directory into which evaluation-tree logs are written."
const LOGS_DIR = joinpath(@__DIR__, "logs")

"Directory browsing starts here so the bundled HGT examples are one keystroke away."
const HGT_EXAMPLES_DIR = joinpath(EXAMPLES_DIR, "hgt")

# --------------------------------------------------------------------------- #
# File selection
# --------------------------------------------------------------------------- #

"""
    prompt(message) -> String

Print `message` (without a trailing newline) and return the user's response with
surrounding whitespace stripped.
"""
function prompt(message::AbstractString)::String
    print(message)
    return strip(readline())
end

"""
    select_json_file(start_dir) -> String

Interactively choose a JSON game file and return its absolute path.

At every step the user may either

  * type an index (`0` goes up one level, `1`…`n` selects the listed entry), or
  * type a path — relative to the current directory or absolute — pointing at a
    file (selected immediately) or a directory (entered).

This allows selecting the bundled examples by number while still supporting files
that live anywhere on disk.
"""
function select_json_file(start_dir::AbstractString)::String
    current_dir = abspath(start_dir)
    isdir(current_dir) || throw(ArgumentError("Starting path '$current_dir' is not a directory."))

    while true
        entries = sort(readdir(current_dir))

        println("\n" * "="^60)
        println("Current directory: ", current_dir)
        println("="^60)
        println("  0. .. (go up one level)")
        for (idx, entry) in enumerate(entries)
            suffix = isdir(joinpath(current_dir, entry)) ? "/" : ""
            println("  $idx. $entry$suffix")
        end

        choice = prompt("\nEnter an index, or a path to a JSON file (relative or absolute): ")

        if isempty(choice)
            println("No input given. Please try again.")
            continue
        end

        # Numeric input navigates the listing above.
        index = tryparse(Int, choice)
        if index !== nothing
            if index == 0
                current_dir = dirname(current_dir)
            elseif 1 <= index <= length(entries)
                current_dir, selected = descend(current_dir, entries[index])
                selected !== nothing && return selected
            else
                println("Index out of range. Choose a number between 0 and $(length(entries)).")
            end
            continue
        end

        # Otherwise treat the input as a path, resolved against the current directory.
        target = isabspath(choice) ? choice : joinpath(current_dir, choice)
        target = abspath(target)
        if isfile(target)
            println("Selected file: ", target)
            return target
        elseif isdir(target)
            current_dir = target
        else
            println("No such file or directory: ", target)
        end
    end
end

"""
    descend(current_dir, entry) -> (dir, file_or_nothing)

Resolve `entry` within `current_dir`. If it is a directory, return it as the new
current directory and `nothing`. If it is a file, return `current_dir` unchanged
together with the file's absolute path.
"""
function descend(current_dir::AbstractString, entry::AbstractString)
    path = joinpath(current_dir, entry)
    if isdir(path)
        return abspath(path), nothing
    else
        println("Selected file: ", path)
        return current_dir, abspath(path)
    end
end

# --------------------------------------------------------------------------- #
# Log paths
# --------------------------------------------------------------------------- #

"""
    is_within(path, root) -> Bool

Return `true` if `path` lies inside `root` (both compared as absolute paths).
"""
function is_within(path::AbstractString, root::AbstractString)::Bool
    rel = relpath(abspath(path), abspath(root))
    return rel != ".." && !startswith(rel, ".." * Base.Filesystem.path_separator)
end

"""
    log_path_for(json_file, timestamp) -> String

Compute the destination path for the evaluation-tree log of `json_file`.

If `json_file` lives inside the `examples/` directory, its sub-directory structure
is mirrored under `logs/` (e.g. `examples/hgt/cop_robber/x.json` becomes
`logs/hgt/cop_robber/x-tree-<timestamp>.md`). Otherwise the log is written directly
into `logs/` with no hierarchy.
"""
function log_path_for(json_file::AbstractString, timestamp::AbstractString)::String
    if is_within(json_file, EXAMPLES_DIR)
        relative = relpath(abspath(json_file), EXAMPLES_DIR)
    else
        relative = basename(json_file)
    end
    stem = replace(relative, r"\.json$" => "")
    return joinpath(LOGS_DIR, "$(stem)-tree-$(timestamp).md")
end

# --------------------------------------------------------------------------- #
# Query evaluation
# --------------------------------------------------------------------------- #

"""
    has_witness(query, result) -> Bool

Return `true` when the evaluation tree contains a meaningful witness worth
summarising: a satisfied existential query, or a refuted universal one. In both
cases the tree encodes the strategy/counter-example whose size is reported.
"""
function has_witness(query::Strategy_Formula, result::Bool)::Bool
    is_existential = isa(query, Exist_Eventually) || isa(query, Exist_Always)
    is_universal = isa(query, All_Eventually) || isa(query, All_Always)
    return (is_existential && result) || (is_universal && !result)
end

"""
    run_queries(game, termination_conditions, queries) -> (results, trees)

Evaluate every query against `game`, printing a per-query summary and the total
elapsed time. Returns the boolean results and the corresponding evaluation trees,
aligned by index with `queries`.
"""
function run_queries(game, termination_conditions, queries)
    results = Bool[]
    trees = RootNode[]

    start = time()
    for query in queries
        result, tree, evaluation_time = check_query(game, termination_conditions, query)
        println("\n$(strategy_to_string(query)): $(result)")
        if has_witness(query, result)
            println(
                "  Nodes = ", count_nodes(tree),
                " | Tree depth = ", depth_of_tree(tree),
                " | Max game time = ", max_time(tree),
            )
        end
        println("  Evaluation time = ", evaluation_time)
        push!(results, result)
        push!(trees, tree)
    end
    elapsed = time() - start

    println("\n" * "*"^60)
    println("Total evaluation time = ", elapsed)
    println("*"^60)

    return results, trees
end

"""
    maybe_save_trees(trees, queries_text, results, json_file)

Offer to write the evaluation trees to a Markdown log and, if the user agrees,
create any required directories and write the file.
"""
function maybe_save_trees(trees, queries_text, results, json_file::AbstractString)
    timestamp = Dates.format(now(), "yyyy-mm-dd_HHMMSS")
    destination = log_path_for(json_file, timestamp)

    answer = lowercase(prompt("\nSave the evaluation tree to $(destination)? (y/n): "))
    if answer != "y" && answer != "yes"
        println("Skipped saving the evaluation tree.")
        return
    end

    mkpath(dirname(destination))
    open(destination, "w") do io
        write(io, print_trees(trees, queries_text, results))
    end
    println("Saved evaluation tree to ", destination)
end

# --------------------------------------------------------------------------- #
# Entry point
# --------------------------------------------------------------------------- #

"""
    main()

Drive one full session: select a game, evaluate its queries, and optionally save
the resulting trees.
"""
function main()
    println("HyTrig — Hybrid Game with Triggers model checker")

    start_dir = isdir(HGT_EXAMPLES_DIR) ? HGT_EXAMPLES_DIR : @__DIR__
    json_file = select_json_file(start_dir)

    game, termination_conditions, queries, queries_text = parse_hgt_game(json_file)
    println("\nLoaded game from ", json_file)

    if isempty(queries)
        println("The selected file declares no queries; nothing to evaluate.")
        return
    end

    results, trees = run_queries(game, termination_conditions, queries)
    maybe_save_trees(trees, queries_text, results, json_file)
end

main()
