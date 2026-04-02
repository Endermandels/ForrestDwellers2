extends StatusEffectRuntime
class_name StatusEffectWeaknessRuntime

func init(res: StatusEffectWeaknessResource) -> void:
	name_id = "Weakness"
	triggers = [Constants.Trigger.TURN_START]

func apply(target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % [target, self])
		return

	Console.print_line("* [%s] was afflicted by [%d] [%s]" % [target, stacks, self])
	target.weakness = stacks
	stacks = 0

	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
