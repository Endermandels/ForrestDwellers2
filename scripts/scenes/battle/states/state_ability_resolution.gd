extends State
class_name StateAbilityResolution

var return_state: State

func step(data: Dictionary) -> State:
	var state: State = null

	var abilities_queue: Array[AbilityRuntime] = data.abilities_queue
	var ability: AbilityRuntime = abilities_queue.pop_front()
	if ability:
		print("* [%s] used [%s]" % [ability.source_unit, ability])
		ability.apply(data.units_queue)
	else:
		state = return_state

	return state

func enter(data: Dictionary) -> void:
	print("~~~ Ability Resolution ~~~")
	return_state = data.prev_state

func exit(data: Dictionary) -> void:
	pass
