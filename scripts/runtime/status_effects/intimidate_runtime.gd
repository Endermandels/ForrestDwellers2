extends StatusEffectRuntime
class_name StatusEffectIntimidateRuntime

var weak_run: WEAKEffectRuntime

func init(res: StatusEffectIntimidateResource) -> void:
	var weak_res: WEAKEffectResource = WEAKEffectResource.new()
	weak_run = WEAKEffectRuntime.new(weak_res)
	
	name_id = "Intimidate"
	triggers = [Constants.Trigger.TURN_START]

func apply(target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % [target, self])
		return

	Console.print_line("* [%s] was afflicted by [%s]" % [target, self])
	weak_run.weak = stacks
	weak_run.apply(source, target)
	stacks = 0

	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
