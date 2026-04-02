extends EffectRuntime
class_name WEAKEffectRuntime

var weak: int ## How much WEAK to apply

func init(res: WEAKEffectResource) -> void:
	name_id = "WEAK"
	weak = res.weak

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return

	Console.print_line("* [%s] suffered [%d] WEAK" % [target, weak])
	target.weak = Helper.clamp_zero(target.weak + weak)
