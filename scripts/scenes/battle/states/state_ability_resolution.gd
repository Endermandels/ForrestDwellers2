extends State
class_name StateAbilityResolution

var next_state: State ## Which state to go to after this one

func step(data: BattleStateData) -> State:
	var state: State = null

	var abilities_queue: Array[AbilityRuntime] = data.abilities_queue
	var ability: AbilityRuntime = abilities_queue.pop_front()
	
	if ability:
		ability.apply(data.battlefield)
	else:
		state = next_state

	return state

func enter(data: BattleStateData) -> void:
	Console.print_line("~~~ Ability Resolution ~~~")
	next_state = data.next_state

func exit(data: BattleStateData) -> void:
	# Reset engaged_opponent to null since all abilities have resolved for an engagement
	for u in data.units_queue:
		u.engaged_opponent = null
