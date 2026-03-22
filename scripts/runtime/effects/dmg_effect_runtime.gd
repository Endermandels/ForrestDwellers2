extends EffectRuntime
class_name DMGEffectRuntime

var is_pure: bool ## Whether it bypasses ARM

func init(res: DMGEffectResource) -> void:
	is_pure = res.is_pure

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	var dmg = value

	if target.is_dead:
		Console.print_line("* [%s] is already dead" % target)
		return
	
	if not is_pure:
		dmg = Helper.clamp_zero(dmg - target.arm)
		target.arm = Helper.clamp_zero(target.arm - value)

	Console.print_line("* [%s] took [%d] DMG" % [target, dmg])
	target.hp = Helper.clamp_zero(target.hp - dmg)
	
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
	else:
		Console.print_line("* [%s] is at [%d] HP" % [target, target.hp])
		if target.arm > 0:
			Console.print_line("* [%s] is at [%d] ARM" % [target, target.arm])
