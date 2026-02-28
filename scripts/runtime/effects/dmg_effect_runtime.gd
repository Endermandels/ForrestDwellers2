extends EffectRuntime
class_name DMGEffectRuntime

var is_pure: bool ## Whether it bypasses ARM

func _init(res: DMGEffectResource) -> void:
    # Defined in EffectRuntime
    name_id = res.name_id
    value = res.value
    # Defined here
    is_pure = res.is_pure

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
    var dmg = value
    if not is_pure:
        dmg = Helper.at_least_zero(dmg - target.arm)
        target.arm = Helper.at_least_zero(target.arm - value)
    target.hp = Helper.at_least_zero(target.hp - dmg)