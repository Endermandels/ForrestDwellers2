extends EffectRuntime
class_name DRNEffectRuntime

var drn: int ## How much DRN to apply

func init(res: DRNEffectResource) -> void:
	drn = res.drn

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return

	Console.print_line("* [%s] suffered [%d] DRN" % [target, drn])
	target.mp = Helper.clamp_zero(target.mp - drn)
