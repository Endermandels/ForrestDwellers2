extends State
class_name StateTurnEnd

@export var turn_start_state: State
@export var status_effect_resolution_state: State
@export var battle_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_start_state
	var cur_unit: UnitRuntime = data.units_queue[0]
	
	# Status Effects
	if data.activate_trigger:
		if not cur_unit.is_dead:
			for se: StatusEffectRuntime in cur_unit.status_effects:
				if Constants.Trigger.TURN_END in se.triggers:
					data.status_effect_queue.append(se)
	else: 
		data.activate_trigger = true
			
	if data.status_effect_queue.size() > 0:
		# Resolve status effects
		data.activate_trigger = false
		data.next_state = self
		state = status_effect_resolution_state
	else:
		# Check Battle End States
		if GameState.player.is_dead:
			state = battle_end_state
			data.player_won = false
		else:
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

		Console.print_line("# [%s] Turn End #" % cur_unit, Color.GREEN)

func exit(data: BattleStateData) -> void:
	if data.activate_trigger:
		# Move front of queue unit to back of queue
		var units_queue: Array[UnitRuntime] = data.units_queue
		var cur_unit = units_queue.pop_front()

		units_queue.append(cur_unit)

		# Reset Stats Modifiers
		cur_unit.weak = 0
		cur_unit.strength = 0
