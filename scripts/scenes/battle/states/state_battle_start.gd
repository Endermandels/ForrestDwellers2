extends State
class_name StateBattleStart

@export var turn_start_state: State

func step(data: BattleStateData) -> State:
	return turn_start_state

func enter(data: BattleStateData) -> void:
	var units_queue: Array[UnitRuntime] = data.units_queue

	Console.print_line("# Battle Start #", Color.GREEN)
	units_queue.sort_custom(func (a: UnitRuntime, b: UnitRuntime): return a.spd > b.spd)

func exit(data: BattleStateData) -> void:
	pass
