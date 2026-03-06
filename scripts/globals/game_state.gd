extends Node
# Global

const PLAYER_RESOURCE = preload("res://resources/units/player.tres")

var player_units: Array[UnitRuntime] = []
var player: UnitRuntime # It's handy to have this available

func init_new_game() -> void:
	var player_res = PLAYER_RESOURCE.duplicate()
	var player_run = UnitRuntime.new(player_res)
	player_units = []
	player_units.append(player_run)
	player = player_run
	print("* Initialized new game")
