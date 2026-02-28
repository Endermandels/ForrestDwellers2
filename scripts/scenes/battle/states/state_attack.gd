extends State
class_name StateAttack

@export var turn_end_state: State

func step(data: Dictionary) -> State:
    var cur_unit: UnitRuntime = data.units_queue[0]
    var target: UnitRuntime = data.units_queue[1]
    var dmg_res = DMGEffectResource.new()
    var dmg_run = DMGEffectRuntime.new(dmg_res)
    dmg_run.value = cur_unit.atk
    dmg_run.apply(cur_unit, target)
    print("* [%s] attacked [%s] for [%d] DMG" % [cur_unit, target, cur_unit.atk])
    print("* [%s] is at [%d] HP" % [target, target.hp])
    return turn_end_state

func enter(data: Dictionary) -> void:
    var cur_unit: UnitRuntime = data.units_queue[0]
    print("~~~ [%s] Attack ~~~" % cur_unit)

func exit(data: Dictionary) -> void:
    pass