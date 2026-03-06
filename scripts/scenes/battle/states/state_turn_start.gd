extends State
class_name StateTurnStart

@export var attack_state: State

func step(data: BattleStateData) -> State:
	return attack_state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]

	print("~~~ [%s] Turn Start ~~~" % cur_unit)

func exit(data: BattleStateData) -> void:
	pass
