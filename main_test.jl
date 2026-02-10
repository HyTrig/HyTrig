include("src/packages.jl")

include("src/parsers/parse_monotic_game.jl")
include("src/game_semantics/zone_semantics/zone.jl")


file_name = "examples/monotonic_hybrid_games/2_player_ball_game.json"


game, termination_conditions, queries, queries_text = parse_mhg_game(file_name)

variables = keys(game.initial_valuation)
z0 = initial_zone(game)

max_location_assignment = constraint_to_assignment(z0.location.invariant, variables)

println("Initial Zone")
println(str(z0))

println("time_to_invariant = ", time_to_invariant(z0, max_location_assignment))



interval_zone::Zone = zone_lift(z0, variables)
println("Location Zone")
println(str(interval_zone))
println("********************")
println("********************")


for edge in game.initial_location.edges
    edge_time, post_edge_zone = zone_shift(interval_zone, edge, variables)
    println("Edge $(edge.name)") 
    println("   time     = ", str(edge_time)) 
    println("   zone = ", str(post_edge_zone)) 
    println("-----------------------")
end
println("********************")
println("********************")