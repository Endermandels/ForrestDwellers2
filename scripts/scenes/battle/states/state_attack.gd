extends State
class_name StateAttack

@export var turn_end_state: State
@export var battle_end_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	var state: State = ability_resolution_state
	var attacker: UnitRuntime = data.units_queue[0]

	assert(not attacker.is_dead, "Dead units should not reach the Attack State")

	# Handle Player attack with valid targets to choose from
	if attacker == GameState.player and data.player_valid_targets.size() > 0:
		if data.player_confirm_selection:
			data.player_confirm_selection = false
			data.defenders_queue.append(data.player_valid_targets[data.player_selected_target])
			data.player_valid_targets = []

			state = _handle_attack(data)
		else:
			state = null

	# Handle NPC or Player without valid targets attack
	else:
		state = _handle_attack(data)

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Attack State")
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("# [%s] Attack #" % cur_unit, Color.GREEN)
	
	# Reset engaged_opponent to null
	for u in data.units_queue:
		u.engaged_opponent = null
	
	# Initialize defenders_queue
	if data.defenders_queue.size() == 0:
		if cur_unit != GameState.player:
			data.defenders_queue = Helper.get_targets(cur_unit, cur_unit.attack_target_rule, data.battlefield)
		else:
			data.player_valid_targets = Helper.get_targets(cur_unit, cur_unit.attack_target_rule, data.battlefield)
			
			if data.player_valid_targets.size() > 0:
				data.player_selected_target = 0
				Console.print_line("> Selected [%s] (/c to confirm, /l to move selection left, /r to move selection right)" % data.player_valid_targets[data.player_selected_target])

func exit(data: BattleStateData) -> void:
	# If there are more defenders left, Ability Resolution State should return to Attack State
	data.next_state = turn_end_state if (data.defenders_queue.size() == 0) else self

func _handle_attack(data: BattleStateData) -> State:
	var state = ability_resolution_state
	var attacker: UnitRuntime = data.units_queue[0]
	var defender: UnitRuntime = data.defenders_queue.pop_front()

	if defender != null:
		var dmg_res: DMGEffectResource = DMGEffectResource.new()
		var dmg_run: DMGEffectRuntime = DMGEffectRuntime.new(dmg_res)

		# Track engaged opponents
		attacker.engaged_opponent = defender
		defender.engaged_opponent = attacker

		# Set defense metrics
		defender.alive_defense = not defender.is_dead
		defender.armored_defense = (defender.arm > 0)
		defender.full_health_defense = (defender.hp == defender.base_hp)

		# Apply attacker's damage to defender (only if the damage is greater than 0)
		dmg_run.dmg = Helper.clamp_zero(attacker.atk - attacker.weakness + attacker.strength)
		if dmg_run.dmg > 0:
			# Alive defenders logic
			if not defender.is_dead:
				Console.print_line("* [%s] attacked [%s]" % [attacker, defender])

				dmg_run.apply(attacker, defender)

				if data.is_end_state():
					state = battle_end_state

				data.handle_deaths()
			else:
				# ! NOTE: Scavenger specific logic
				Console.print_line("* [%s] devoured [%s]" % [attacker, defender])
				data.remove_unit(defender)

			# Trigger On Hit abilities
			if not attacker.is_dead:
				data.trigger_unit_abilities(attacker, Constants.Trigger.ON_HIT)
		else:
			Console.print_line("* [%s] is too weak to attack" % attacker)
	else:
		Console.print_line("* No valid targets left")

	return state