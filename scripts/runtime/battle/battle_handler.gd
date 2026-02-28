extends Node # TODO: Extend Saveable
class_name BattleHandler

@export var state_machine: StateMachine
var units_queue: Array[UnitRuntime] = []

func _ready() -> void:
    state_machine.data = { "units_queue": units_queue }

func add_unit(unit: UnitRuntime) -> void:
    units_queue.append(unit)
    add_child(unit)
    print("* Added unit: [%s]" % unit)

## Handle the next step in the battle
func step() -> void:
    state_machine.step()