extends State
class_name StateAttack

@export var turn_end_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_state

	var attacker: UnitRuntime = data.units_queue[0]
	var abilities_queue: Array[AbilityRuntime] = data.abilities_queue

	# It is possible to get here and the attacker is dead, so just move along to the next state
	if not attacker.is_dead:
		if attacker == GameState.player and data.defenders_queue.size() == 0 and data.player_valid_targets.size() > 0:
			# Allow player to choose defender
			if data.player_confirm_selection:
				data.player_confirm_selection = false
				data.defenders_queue.append(data.player_valid_targets[data.player_selected_target])
				data.player_valid_targets = []
			else:
				state = null

		# Only null when the player hasn't confirmed a defender on the player's turn
		if state != null:
			var defender: UnitRuntime = data.defenders_queue.pop_front()

			if defender:
				var dmg_res: DMGEffectResource = DMGEffectResource.new()
				var dmg_run: DMGEffectRuntime = DMGEffectRuntime.new(dmg_res)

				# Track engaged opponents
				attacker.engaged_opponent = defender
				defender.engaged_opponent = attacker

				# Set armored defense if applicable
				defender.armored_defense = defender.arm > 0

				# Apply attacker's damage to defender
				dmg_run.dmg = attacker.atk
				dmg_run.apply(attacker, defender)

				# Load abilities queue
				for a: AbilityRuntime in attacker.abilities_dict[Constants.Trigger.keys()[Constants.Trigger.ON_HIT]]:
					abilities_queue.append(a)

				# Transition to Ability Resolution State if there are abilities to resolve
				if abilities_queue.size() > 0:
					state = ability_resolution_state
			else:
				Console.print_line("* No valid targets left")
	else:
		Console.print_line("* [%s] is dead" % attacker)

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("~~~ [%s] Attack ~~~" % cur_unit)
	if data.defenders_queue.size() == 0:
		# Initialize defenders_queue
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
