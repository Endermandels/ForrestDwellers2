extends Node
# Global

const PLAYER_RESOURCE = preload("res://resources/units/player.tres")
const WOLF_RESOURCE = preload("res://resources/units/wolf.tres") # TODO: DELETE
const SNAKE_RESOURCE = preload("res://resources/units/snake.tres") # TODO: DELETE

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
		var res = WOLF_RESOURCE.duplicate() if i != 0 else SNAKE_RESOURCE.duplicate()
		var run = UnitRuntime.new(res)

		run.is_enemy = false
		run.position = player_run.position + i + 1
		player_units.append(run)
	#endregion

	player = player_run
	print("* Initialized new game")
