extends Node
class_name EffectRuntime

var name_id: String
var value: int
# TODO: Expand as necessary

func _init(res: EffectResource) -> void:
    # Defined in EffectRuntime
    name_id = res.name_id
    value = res.value
    # Defined here
    # TODO: Implement as necessary

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
    # TODO: Implement
    pass