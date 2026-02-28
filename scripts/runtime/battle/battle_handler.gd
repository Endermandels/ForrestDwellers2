extends Node
class_name BattleHandler

var units_queue: Array[UnitRuntime] = []

func _ready() -> void:
    print("~~~ Battle Handler ~~~")

func add_unit(unit: UnitRuntime) -> void:
    units_queue.append(unit)
    add_child(unit)
    print("* Added unit: [%s]" % unit)

## Handle the next step in the battle
func step() -> void:
    pass