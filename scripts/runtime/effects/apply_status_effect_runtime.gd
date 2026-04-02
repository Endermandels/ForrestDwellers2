extends EffectRuntime
class_name ApplyStatusEffectRuntime

var se_res: StatusEffectResource

func init(res: ApplyStatusEffectResource) -> void:
	se_res = res.status_effect
	name_id = "Apply Status Effect"

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	var se_run: StatusEffectRuntime = StatusEffectRuntime.from_resource(se_res, source)
	var found_status_effect: bool = false

	if target.is_dead:
		Console.print_line("* [%s] is dead and cannot gain a status effect" % target)
		return
	
	Console.print_line("* [%s] gained [%d] stacks of [%s]" % [target, se_run.stacks, se_run])

	for se: StatusEffectRuntime in target.status_effects:
		if se.name_id == se_run.name_id:
			se.stacks += se_run.stacks
			found_status_effect = true

	if not found_status_effect:
		target.status_effects.append(se_run)
