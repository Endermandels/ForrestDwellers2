extends StatusEffectRuntime
class_name StatusEffectFearRuntime

func init(res: StatusEffectFearResource) -> void:
	pass

func apply(target: UnitRuntime) -> void:
	assert(stacks > 0, "Stacks must be greater than zero")

	if target.is_dead:
		Console.print_line("* [%s] is dead" % [target, self])
		return

	Console.print_line("* [%s] was afflicted by [%d] [%s]" % [target, stacks, self])
	target.fear = stacks
	stacks -= 1

	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
