extends State
class_name StateTurnStart2

@export var attack_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Turn Start 2 State")

	# Trigger Turn Start Abilities
	data.trigger_unit_abilities(cur_unit, Constants.Trigger.TURN_START)

	data.next_state = attack_state
	return ability_resolution_state

func enter(data: BattleStateData) -> void:
	print("* Entered Turn Start 2 State")

func exit(data: BattleStateData) -> void:
	pass
