
include("src/parsers/parse_monotic_game.jl")
include("src/game_semantics/zone_semantics/zone.jl")


file_name = "examples/monotonic_hybrid_games/2_player_ball_game.json"


game, termination_conditions, queries, queries_text = parse_mhg_game(file_name)

println(str(initial_zone(game)))
for edge in game.initial_location.edges
    edge_time, post_edge_zone = zone_shift(initial_zone(game), edge)
    println("Edge $(edge.name)") 
    println("   time     = ", str(edge_time)) 
    println("   zone = ", str(post_edge_zone)) 
    println("-----------------------")
end