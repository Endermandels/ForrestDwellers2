extends Node
class_name UnitSpawner

@export var battle_handler: BattleHandler
@export var enemy_units: Array[UnitResource] = []

# TODO: Randomize enemy units

func _ready() -> void:
	for u: UnitRuntime in GameState.player_units:
		battle_handler.add_unit(u)
	for u: UnitResource in enemy_units:
		var runtime = UnitRuntime.new(u)
		battle_handler.add_unit(runtime)
