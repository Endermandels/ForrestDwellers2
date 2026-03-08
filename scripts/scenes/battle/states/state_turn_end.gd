extends State
class_name StateTurnEnd

@export var turn_start_state: State
@export var battle_end_state: State

func step(data: BattleStateData) -> State:
	var state: State = turn_start_state

	# Check player HP
	if Helper.stat_is_depleted(GameState.player.hp):
		state = battle_end_state
		data.player_won = false
	else:
		var no_enemies_left: bool = true

		# Check all enemies HP
		for u: UnitRuntime in data.units_queue:
			if u.is_enemy and not Helper.stat_is_depleted(u.hp):
				no_enemies_left = false
				break

		if no_enemies_left:
			state = battle_end_state
			data.player_won = true

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRuntime = data.units_queue[0]

	Console.print_line("~~~ [%s] Turn End ~~~" % cur_unit)

func exit(data: BattleStateData) -> void:
	# Move front of queue unit to back of queue
	var units_queue: Array[UnitRuntime] = data.units_queue
	var cur_unit = units_queue.pop_front()

	units_queue.append(cur_unit)
