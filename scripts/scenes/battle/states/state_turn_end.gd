extends State
class_name StateTurnEnd

@export var turn_end_2_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	var cur_unit: UnitRuntime = data.units_queue[0]
	
	assert(not cur_unit.is_dead, "Dead units should not reach the Turn End State")
	
	# Trigger Turn End Abilities
	data.trigger_unit_abilities(cur_unit, Constants.Trigger.TURN_END)

	data.next_state = turn_end_2_state
	return ability_resolution_state

func enter(data: BattleStateData) -> void:
	print("* Entered Turn End State")
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("# [%s] Turn End #" % cur_unit, Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass
