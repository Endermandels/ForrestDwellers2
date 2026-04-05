extends State
class_name StateTurnStart

@export var stun_state: State
@export var status_effect_resolution_state: State

func step(data: BattleStateData) -> State:
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Turn Start State")

	# Trigger Turn Start Status Effects
	data.trigger_status_effects(cur_unit, Constants.Trigger.TURN_START)

	data.next_state = stun_state
	return status_effect_resolution_state

func enter(data: BattleStateData) -> void:
	print("* Entered Turn Start State")
	data.next_unit()

	var cur_unit: UnitRuntime = data.units_queue[0]

	# Cycle dead units until an alive unit surfaces
	while cur_unit.is_dead:
		data.next_unit()
		cur_unit = data.units_queue[0]

	Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass
