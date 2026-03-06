extends Node
class_name State

## Returns the new State to transition to or null
func step(data: Dictionary) -> State:
	# TODO: Implement
	return null

## Called upon transitioning to this state
func enter(data: Dictionary) -> void:
	# TODO: Implement
	pass

## Called upon transitioning from this state
func exit(data: Dictionary) -> void:
	# TODO: Implement
	pass
