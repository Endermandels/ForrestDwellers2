extends State
class_name StateTurnStart

@export var attack_state: State

func step(data: Dictionary) -> State:
	return attack_state

func enter(data: Dictionary) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]
	print("~~~ [%s] Turn Start ~~~" % cur_unit)

func exit(data: Dictionary) -> void:
	pass
