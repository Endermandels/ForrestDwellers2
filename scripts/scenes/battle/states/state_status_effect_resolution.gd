extends State
class_name StateStatusEffectResolution

var next_state: State ## Which state to go to after this one

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRuntime = data.units_queue[0]

	var status_effects_queue: Array[StatusEffectRuntime] = data.status_effect_queue
	var status_effect: StatusEffectRuntime = status_effects_queue.pop_front()
	
	if status_effect:
		status_effect.apply(cur_unit)
		if status_effect.stacks <= 0:
			cur_unit.status_effects.erase(status_effect)
			Console.print_line("* [%s] removed" % status_effect)
	else:
		state = next_state

	return state

func enter(data: BattleStateData) -> void:
	Console.print_line("~~~ Status Effect Resolution ~~~")
	next_state = data.next_state

func exit(data: BattleStateData) -> void:
	pass
