extends Node
# Global

const PLAYER_RESOURCE = preload("res://resources/units/player.tres")
const WOLF_RESOURCE = preload("res://resources/units/wolf.tres") # TODO: DELETE
const SNAKE_RESOURCE = preload("res://resources/units/snake.tres") # TODO: DELETE
const BEAR_RESOURCE = preload("res://resources/units/bear.tres") # TODO: DELETE

const debug_player_units = [
	null,
	BEAR_RESOURCE,
	null,
	null,
	PLAYER_RESOURCE,
	null
] #TODO: DELETE

var player_units: Array[UnitRuntime] = []
var player: UnitRuntime # It's handy to have this available

## TODO: DELETE (for debugging)
func init_new_game() -> void:
	player_units = []
	for i in range(6):
		var res = debug_player_units[i]
		if res != null:
			res = res.duplicate()
			var run = UnitRuntime.new(res)

			run.is_enemy = false
			run.position = i + 6
			player_units.append(run)

			if run.name_id == "Player":
				player = run

	print("* Initialized new game")

## TODO: Uncomment
# func init_new_game() -> void:
# 	var player_res = PLAYER_RESOURCE.duplicate()
# 	var player_run = UnitRuntime.new(player_res)

# 	player_run.position = 7 # Mid-Frontline on the player's side
# 	player = player_run

# 	player_units = []
# 	player_units.append(player_run)

# 	print("* Initialized new game")
