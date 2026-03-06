extends Node # TODO: Extend Saveable
class_name BattleHandler

@export var state_machine: StateMachine
var units_queue: Array[UnitRuntime] = []
var abilities_queue: Array[AbilityRuntime] = []

func _ready() -> void:
	state_machine.data = { "units_queue": units_queue, "abilities_queue": abilities_queue }

func add_unit(unit: UnitRuntime) -> void:
	units_queue.append(unit)
	add_child(unit)
	print("* Added unit: [%s]" % unit)

static func get_targets(target_rule: Constants.TargetRule, source: UnitRuntime, units: Array[UnitRuntime]) -> Array[UnitRuntime]:
	var res = []
	if target_rule == Constants.TargetRule.ENEMY:
		res.append(source.engaged_enemy)
	return res

## Handle the next step in the battle
func step() -> void:
	state_machine.step()