extends Node
class_name UnitSpawner

@export var enemy_units: Array[UnitResource] = []

# TODO: Randomize enemy units

func get_units_to_spawn() -> Array[UnitRuntime]:
	var res: Array[UnitRuntime] = []

	for u: UnitRuntime in GameState.player_units:
		res.append(u)
		add_child(u)
	for u: UnitResource in enemy_units:
		var runtime = UnitRuntime.new(u)
		res.append(runtime)
		add_child(runtime)
	
	return res
