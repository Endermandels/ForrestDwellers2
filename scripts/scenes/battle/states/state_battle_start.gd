extends State
class_name StateBattleStart

@export var turn_start_state: State

func step(data: Dictionary) -> State:
	return turn_start_state

func enter(data: Dictionary) -> void:
	print("~~~ Battle Start ~~~")
	var units_queue: Array[UnitRuntime] = data.units_queue
	units_queue.sort_custom(func (a: UnitRuntime, b: UnitRuntime): return a.spd > b.spd)

func exit(data: Dictionary) -> void:
	pass
