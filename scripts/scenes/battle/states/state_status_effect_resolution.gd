extends State
class_name StateStatusEffectResolution

@export var ability_resolution_state: State

var next_state: State ## Which state to go to after this one

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRuntime = data.units_queue[0]

	# ! NOTE: Dead units cannot have status effects
	assert(not cur_unit.is_dead, "Current Unit should not be dead here")

	var status_effects_queue: Array[StatusEffectRuntime] = data.status_effect_queue
	var status_effect: StatusEffectRuntime = status_effects_queue.pop_front()
	
	if status_effect:
		status_effect.apply(cur_unit)
		if cur_unit.is_dead:
			# Dead units cannot have status effects
			cur_unit.status_effects.clear()

			# Trigger ON_DEATH abilities
			for u: UnitRuntime in data.units_queue:
				for a: AbilityRuntime in u.abilities_dict[Constants.Trigger.keys()[Constants.Trigger.ON_DEATH]]:
					data.abilities_queue.append(a)

			# Transition to Ability Resolution State if there are abilities to resolve, otherwise to next_state
			if data.abilities_queue.size() > 0:
				data.next_state = next_state
				state = ability_resolution_state
			else:
				state = next_state
		elif status_effect.stacks <= 0:
			cur_unit.status_effects.erase(status_effect)
			Console.print_line("* [%s] removed" % status_effect)
	else:
		state = next_state

	return state

func enter(data: BattleStateData) -> void:
	Console.print_line("# Status Effect Resolution #", Color.GREEN)
	next_state = data.next_state


func exit(data: BattleStateData) -> void:
	pass
