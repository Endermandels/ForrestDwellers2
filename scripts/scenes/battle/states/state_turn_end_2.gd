extends State
class_name StateTurnEnd2

@export var turn_start_state: State
@export var status_effect_resolution_state: State

func step(data: BattleStateData) -> State:
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Turn End 2 State")

	# Trigger Turn End Status Effects
	data.trigger_status_effects(cur_unit, Constants.Trigger.TURN_END)

	data.next_state = turn_start_state
	return status_effect_resolution_state

func enter(data: BattleStateData) -> void:
	print("* Entered Turn End 2 State")

func exit(data: BattleStateData) -> void:
	pass
