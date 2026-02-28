extends Node
# Global

const PLAYER_RESOURCE = preload("res://resources/units/player.tres")

var player_units: Array[UnitRuntime] = []

func init_new_game() -> void:
    var player_res = PLAYER_RESOURCE.duplicate()
    var player_run = UnitRuntime.new(player_res)
    player_units = []
    player_units.append(player_run)
    print("* Initialized new game")