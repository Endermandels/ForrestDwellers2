extends State
class_name StateAttack

@export var turn_end_state: State

func step(data: Dictionary) -> State:
    return turn_end_state

func enter(data: Dictionary) -> void:
    var cur_unit: UnitRuntime = data.units_queue[0]
    print("~~~ Attack [%s] ~~~" % cur_unit)

func exit(data: Dictionary) -> void:
    pass