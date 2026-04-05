extends State
class_name StateStunCheck

@export var terror_state: State
@export var turn_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = terror_state
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Stun Check State")

	if cur_unit.is_stunned:
		Console.print_line("* [%s] is stunned" % cur_unit)
		state = turn_end_state

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Stun Check State")

func exit(data: BattleStateData) -> void:
	pass

