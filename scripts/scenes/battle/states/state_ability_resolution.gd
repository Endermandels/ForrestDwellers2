extends State
class_name StateAbilityResolution

@export var battle_end_state: State
@export var turn_start_state: State

func step(data: BattleStateData) -> State:
	var state: State = null

	if data.effects_queue.size() > 0:
		var effect: Callable = data.effects_queue.pop_front()
		effect.call()
		
		if data.is_end_state():
			state = battle_end_state
		
		data.handle_deaths()
	else:
		var ability: AbilityRuntime = data.abilities_queue.pop_front()
		
		if ability != null:
			_handle_ability(data, ability)
		else:
			# Bypass data.next_state if current unit is dead; go to Turn Start State
			var cur_unit: UnitRuntime = data.units_queue[0]
			
			state = turn_start_state if cur_unit.is_dead else data.next_state

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Ability Resolution State")
	if data.abilities_queue.size() > 0:
		Console.print_line("# Ability Resolution #", Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass

func _handle_ability(data: BattleStateData, ability: AbilityRuntime) -> void:
	assert((not ability.source_unit.is_dead) or (Constants.Trigger.ON_DEATH in ability.triggers), "Must be alive to use an ability other than On Death abilities")

	# Make sure ability conditions are met
	var all_conditions_met = true

	for c in ability.conditions:
		if not c.is_met(ability.source_unit, data.battlefield):
			all_conditions_met = false
			break
	
	if all_conditions_met:
		# Use ability!
		Console.print_line("* [%s] used [%s]" % [ability.source_unit, ability])
		for e in ability.effects:
			var targets = Helper.get_targets(ability.source_unit, e.target_rule, data.battlefield)

			data.effects_queue.append(_apply_effects.bind(targets, e, ability))
	else:
		Console.print_line("* [%s] could not use [%s]" % [ability.source_unit, ability])

func _apply_effects(targets: Array[UnitRuntime], effect: EffectRuntime, ability: AbilityRuntime) -> void:
	for u in targets:
		effect.apply(ability.source_unit, u)
