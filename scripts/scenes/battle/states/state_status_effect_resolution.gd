extends State
class_name StateStatusEffectResolution

@export var ability_resolution_state: State
@export var battle_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units cannot have status effects")

	var status_effect: StatusEffectRuntime = data.status_effects_queue.pop_front()

	if status_effect != null:
		status_effect.apply(cur_unit)

		# Remove depleted status effects
		if status_effect.stacks <= 0:
			cur_unit.status_effects.erase(status_effect)
			Console.print_line("* [%s] removed" % status_effect)

		if data.is_end_state():
			state = battle_end_state

		elif data.handle_deaths():
			# Current unit is dead
			assert(cur_unit.is_dead, "Status Effects should only affect the current unit")
			state = ability_resolution_state
	else:
		state = data.next_state

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Status Effect Resolution State")
	if data.status_effects_queue.size() > 0:
		Console.print_line("# Status Effect Resolution #", Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass
