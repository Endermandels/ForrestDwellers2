extends State
class_name StateTurnStart

@export var attack_state: State
@export var status_effect_resolution_state: State
@export var turn_end_state: State
@export var battle_end_state: State

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
		state = turn_end_state if (cur_unit.is_dead or cur_unit.is_stunned) else attack_state
	
	# Before entering attack state, check fear (except for Player)
	if state == attack_state and cur_unit != GameState.player:
		var cap = (30 if cur_unit.is_enemy else 10)
		var rnd = randi_range(0, cap)

		if rnd < cur_unit.fear:
			# Flee!
			Console.print_line("* [%s] fled out of fear" % cur_unit)
			data.units_queue.pop_front()
			data.battlefield[cur_unit.position] = null
			state = self

			# Check if an enemy fled and all enemies are gone
			var no_enemies_left: bool = true

			# Check all enemies HP
			for u: UnitRuntime in data.units_queue:
				if u.is_enemy and not u.is_dead:
					no_enemies_left = false
					break

			if no_enemies_left:
				state = battle_end_state
				data.player_won = true

	return state

func enter(data: BattleStateData) -> void:
	if data.activate_trigger:
		var cur_unit: UnitRuntime = data.units_queue[0]

		Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)

func exit(data: BattleStateData) -> void:
	pass
