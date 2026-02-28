extends Node
class_name StateMachine

@export var cur_state: State ## Must be initialized to the starting state
@export var data: Dictionary ## Data that can be modified by the states (optional)
var states: Array[State] = []

func _ready() -> void:
    for s in get_children():
        states.append(s)
    cur_state.enter(data)

func step() -> void:
    var new_state = cur_state.step(data)
    if new_state:
        cur_state.exit(data)
        new_state.enter(data)
        cur_state = new_state
