extends EffectRuntime
class_name DMGEffectRuntime

var dmg: int ## How much DMG to apply
var is_pure: bool ## Whether it bypasses ARM

func init(res: DMGEffectResource) -> void:
	name_id = "DMG"
	is_pure = res.is_pure
	dmg = res.dmg

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	var dmg_mod: int = dmg

	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return
	
	Console.print_line("* [%s] suffered [%d] DMG" % [target, dmg_mod])
	
	if not is_pure:
		dmg_mod = Helper.clamp_zero(dmg_mod - target.arm)
		target.arm = Helper.clamp_zero(target.arm - dmg)

	target.hp = Helper.clamp_zero(target.hp - dmg_mod)
	
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
	else:
		Console.print_line("* [%s] is at [%d] HP" % [target, target.hp])
		if target.armored_defense:
			Console.print_line("* [%s] is at [%d] ARM" % [target, target.arm])
