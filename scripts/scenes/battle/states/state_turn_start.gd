extends State
class_name StateTurnStart

@export var attack_state: State
@export var turn_end_state: State

func step(data: BattleStateData) -> State:
	var cur_unit: UnitRuntime = data.units_queue[0]
	
	return turn_end_state if cur_unit.is_dead else attack_state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("~~~ [%s] Turn Start ~~~" % cur_unit)

func exit(data: BattleStateData) -> void:
	pass
