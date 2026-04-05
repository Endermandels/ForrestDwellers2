extends State
class_name StateTerrorCheck

@export var turn_start_state: State
@export var turn_start_state_2: State
@export var battle_end_state: State

func step(data: BattleStateData) -> State:
	var state = turn_start_state_2
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Terror Check State")
	
	# Player won't flee
	if cur_unit != GameState.player:
		var cap = (30 if cur_unit.is_enemy else 10) # Player animals are harder to scare away
		var rnd = randi_range(0, cap)

		if rnd < cur_unit.fear:
			# Flee!
			Console.print_line("* [%s] fled out of fear" % cur_unit)

			# Remove unit from the battlefield and units_queue			
			data.units_queue.pop_front()
			data.battlefield[cur_unit.position] = null
			state = turn_start_state

			if data.is_end_state():
				state = battle_end_state

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Terror Check State")

func exit(data: BattleStateData) -> void:
	pass
