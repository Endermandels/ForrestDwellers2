extends State
class_name StateTerrorCheck

@export var turn_start_state: State
@export var turn_start_state_2: State
@export var battle_end_state: State

func step(data: BattleStateData) -> State:
	var state = turn_start_state_2
	var cur_unit: UnitRuntime = data.units_queue[0]

	assert(not cur_unit.is_dead, "Dead units should not reach the Terror Check State")
	
	# Player won't flee, nor will a unit without fear
	if cur_unit != GameState.player and cur_unit.fear > 0:
		var rnd: float = randf()
		var flee_chance: float = 7.0 / (7.0 + pow(float(cur_unit.fear) / 10.0, -cur_unit.courage)) # Base chance of 7/8

		print("Flee Chance: %f" % flee_chance)

		if rnd < flee_chance:
			# Flee!
			Console.print_line("* [%s] fled out of fear" % cur_unit)

			# Remove unit from battle			
			data.remove_unit(cur_unit)
			state = battle_end_state if data.is_end_state() else turn_start_state
			
			# Use the first unit in data.units_queue
			data.cycle_next_unit = false

	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Terror Check State")

func exit(data: BattleStateData) -> void:
	pass
