extends Node # TODO: Extend Saveable
class_name BattleHandler

@export var state_machine: StateMachine
var units_queue: Array[UnitRuntime] = []
var abilities_queue: Array[AbilityRuntime] = []

func _ready() -> void:
	state_machine.data = { "units_queue": units_queue, "abilities_queue": abilities_queue }

func add_unit(unit: UnitRuntime) -> void:
	var node = null

	# Add unit to queue and as a child of Battle Handler
	units_queue.append(unit)
	add_child(unit)

	# Add unit's abilities as children of that unit
	node = get_child(-1)
	for a in unit.abilities:
		node.add_child(a)

	print("* Added unit: [%s]" % unit)

static func get_targets(target_rule: Constants.TargetRule, source: UnitRuntime, units: Array[UnitRuntime]) -> Array[UnitRuntime]:
	var res: Array[UnitRuntime] = []

	if target_rule == Constants.TargetRule.ENEMY:
		res.append(source.engaged_enemy)
	else:
		push_error("Unknown Target Rule: " + Constants.TargetRule.keys()[target_rule])
	return res

## Handle the next step in the battle
func step() -> void:
	state_machine.step()
