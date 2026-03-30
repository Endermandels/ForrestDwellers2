extends EffectRuntime
class_name STREffectRuntime

var strength: int ## How much STR to apply

func init(res: STREffectResource) -> void:
	strength = res.strength

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return

	Console.print_line("* [%s] gained [%d] STR" % [target, strength])
	target.strength = Helper.clamp_zero(target.strength + strength)
