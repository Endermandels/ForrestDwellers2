extends State
class_name StateTurnEnd

@export var turn_start_state: State

func step(data: Dictionary) -> State:
    return turn_start_state

func enter(data: Dictionary) -> void:
    var cur_unit: UnitRuntime = data.units_queue[0]
    print("~~~ [%s] Turn End ~~~" % cur_unit)

func exit(data: Dictionary) -> void:
    # Move front of queue unit to back of queue
    var units_queue: Array[UnitRuntime] = data.units_queue
    var cur_unit = units_queue.pop_front()
    units_queue.append(cur_unit)