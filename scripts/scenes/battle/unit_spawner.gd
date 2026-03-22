extends Node
class_name UnitSpawner

@export var encounter: Encounter

## Return an array of enemy units from the predetermined [encounter]
func _get_enemy_units() -> Array[UnitRuntime]:
	var enemy_units: Array[UnitRuntime] = []
	var col = 0

	for res: UnitResource in encounter.backline_units:
		if res != null: # Empty space
			var run = UnitRuntime.new(res)

			run.position = Helper.get_pos(Constants.BF_ENEMY_BACKLINE_ROW, col)
			enemy_units.append(run)
		col += 1
	
	col = 0

	for res: UnitResource in encounter.frontline_units:
		if res != null: # Empty space
			var run = UnitRuntime.new(res)

			run.position = Helper.get_pos(Constants.BF_ENEMY_FRONTLINE_ROW, col)
			enemy_units.append(run)
		col += 1

	return enemy_units

## Get all units to spawn onto the battlefield
func get_units_to_spawn() -> Array[UnitRuntime]:
	var enemy_units = _get_enemy_units()
	var res: Array[UnitRuntime] = []

	for u: UnitRuntime in GameState.player_units:
		res.append(u)
		add_child(u)
	for u: UnitRuntime in enemy_units:
		res.append(u)
		add_child(u)
	
	return res
