extends StatusEffectRuntime
class_name StatusEffectStunRuntime

func init(res: StatusEffectStunResource) -> void:
	name_id = "Stun"
	triggers = [Constants.Trigger.TURN_START]

func apply(target: UnitRuntime) -> void:
	assert(stacks > 0, "Stacks must be greater than zero")

	if target.is_dead:
		Console.print_line("* [%s] is dead" % [target, self])
		return

	Console.print_line("* [%s] was afflicted by [%s]" % [target, self])
	target.is_stunned = true
	stacks -= 1

	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
