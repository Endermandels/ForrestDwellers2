extends State
class_name StateAttack

@export var turn_end_state: State
@export var ability_resolution_state: State

func step(data: Dictionary) -> State:
	var state: State = turn_end_state

	var cur_unit: UnitRuntime = data.units_queue[0]
	var target: UnitRuntime = data.units_queue[1]
	var abilities_queue: Array[AbilityRuntime] = data.abilities_queue

	var dmg_res = DMGEffectResource.new()
	var dmg_run = DMGEffectRuntime.new(dmg_res)
	dmg_run.value = cur_unit.atk
	dmg_run.apply(cur_unit, target)

	print("* [%s] attacked [%s] for [%d] DMG" % [cur_unit, target, cur_unit.atk])
	print("* [%s] is at [%d] HP" % [target, target.hp])

	for a: AbilityRuntime in cur_unit.abilities[Constants.Trigger.keys()[Constants.Trigger.ON_HIT]]:
		abilities_queue.append(a)

	if abilities_queue.size() > 0:
		state = ability_resolution_state

	return state

func enter(data: Dictionary) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]
	print("~~~ [%s] Attack ~~~" % cur_unit)

func exit(data: Dictionary) -> void:
	data["prev_state"] = self
