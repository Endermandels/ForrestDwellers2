extends State
class_name StateAbilityResolution

var next_state: State ## Which state to go to after this one

func step(data: Dictionary) -> State:
	var state: State = null

	var abilities_queue: Array[AbilityRuntime] = data.abilities_queue
	var ability: AbilityRuntime = abilities_queue.pop_front()
	if ability:
		print("* [%s] used [%s]" % [ability.source_unit, ability])
		ability.apply(data.units_queue)
	else:
		state = next_state

	return state

func enter(data: Dictionary) -> void:
	print("~~~ Ability Resolution ~~~")
	next_state = data.next_state

func exit(data: Dictionary) -> void:
	pass
