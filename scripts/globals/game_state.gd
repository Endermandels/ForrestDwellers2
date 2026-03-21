extends Node
# Global

const PLAYER_RESOURCE = preload("res://resources/units/player.tres")
const WOLF_RESOURCE = preload("res://resources/units/wolf.tres") # TODO: DELETE

var player_units: Array[UnitRuntime] = []
var player: UnitRuntime # It's handy to have this available

func init_new_game() -> void:
	var player_res = PLAYER_RESOURCE.duplicate()
	var player_run = UnitRuntime.new(player_res)

	player_run.position = 6 # Left-Frontline on the player's side

	player_units = []
	player_units.append(player_run)

	#region #TODO: DELETE
	for i in range(5):
		var w_res = WOLF_RESOURCE.duplicate()
		var w_run = UnitRuntime.new(w_res)

		w_run.is_enemy = false
		w_run.position = player_run.position + i + 1
		player_units.append(w_run)
	#endregion

	player = player_run
	print("* Initialized new game")
