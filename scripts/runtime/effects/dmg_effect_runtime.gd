extends EffectRuntime
class_name DMGEffectRuntime

var is_pure: bool ## Whether it bypasses ARM

func init(res: DMGEffectResource) -> void:
	is_pure = res.is_pure

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	var dmg = value
	
	if not is_pure:
		dmg = Helper.clamp_zero(dmg - target.arm)
		target.arm = Helper.clamp_zero(target.arm - value)
	target.hp = Helper.clamp_zero(target.hp - dmg)
	Console.print_line("* [%s] took [%d] DMG" % [target, dmg])
	Console.print_line("* [%s] is at [%d] HP" % [target, target.hp])
	Console.print_line("* [%s] is at [%d] ARM" % [target, target.arm])
