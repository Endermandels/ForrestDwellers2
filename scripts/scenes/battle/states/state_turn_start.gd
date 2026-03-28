extends State
class_name StateTurnStart

@export var attack_state: State
@export var status_effect_resolution_state: State
@export var turn_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_state
	var cur_unit: UnitRuntime = data.units_queue[0]

	if not cur_unit.is_dead:
		for se: StatusEffectRuntime in cur_unit.status_effects:
			if Constants.Trigger.TURN_START in se.triggers:
				data.status_effect_queue.append(se)
		
		if data.status_effect_queue.size() > 0:
			data.next_state = attack_state
			state = status_effect_resolution_state
		else:
			state = attack_state
	
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("~~~ [%s] Turn Start ~~~" % cur_unit)

func exit(data: BattleStateData) -> void:
	pass
