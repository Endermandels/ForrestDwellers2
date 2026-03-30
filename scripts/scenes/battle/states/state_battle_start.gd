extends State
class_name StateBattleStart

@export var turn_start_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_start_state

	# Load abilities queue
	for u: UnitRuntime in data.units_queue:
		for a: AbilityRuntime in u.abilities_dict[Constants.Trigger.keys()[Constants.Trigger.BATTLE_START]]:
			data.abilities_queue.append(a)

	# Transition to Ability Resolution State if there are abilities to resolve
	if data.abilities_queue.size() > 0:
		data.next_state = turn_start_state
		state = ability_resolution_state

	return state

func enter(data: BattleStateData) -> void:
	var units_queue: Array[UnitRuntime] = data.units_queue

	Console.print_line("# Battle Start #", Color.GREEN)
	units_queue.sort_custom(func (a: UnitRuntime, b: UnitRuntime): return a.spd > b.spd)

func exit(data: BattleStateData) -> void:
	pass
