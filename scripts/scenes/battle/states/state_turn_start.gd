extends State
class_name StateTurnStart

@export var attack_state: State
@export var status_effect_resolution_state: State
@export var turn_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_state
	var cur_unit: UnitRuntime = data.units_queue[0]

	# Status Effects
	if data.activate_trigger:
		if not cur_unit.is_dead:
			for se: StatusEffectRuntime in cur_unit.status_effects:
				if Constants.Trigger.TURN_START in se.triggers:
					data.status_effect_queue.append(se)
			
			if data.status_effect_queue.size() > 0:
				# Resolve status effects
				data.activate_trigger = false
				data.next_state = self
				state = status_effect_resolution_state
			else:
				state = attack_state
	else:
		data.activate_trigger = true
		state = turn_end_state if cur_unit.is_dead else attack_state
	
	return state

func enter(data: BattleStateData) -> void:
	if data.activate_trigger:
		var cur_unit: UnitRuntime = data.units_queue[0]

		Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass
