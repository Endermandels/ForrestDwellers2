extends StatusEffectRuntime
class_name StatusEffectPoisonRuntime

func init(res: StatusEffectPoisonResource) -> void:
	pass

func apply(target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead and cannot apply [%s]" % [target, self])
		return
	
	Console.print_line("* [%s] was afflicted by [%s]" % [target, self])
	for e: EffectRuntime in effects:
		e.apply(source, target)
	
	stacks -= 1 # TODO: Change this
	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
