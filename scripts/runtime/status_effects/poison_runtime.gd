extends StatusEffectRuntime
class_name StatusEffectPoisonRuntime

var dmg_run: DMGEffectRuntime

func init(res: StatusEffectPoisonResource) -> void:
	var dmg_res: DMGEffectResource = DMGEffectResource.new()
	dmg_res.is_pure = true
	dmg_res.dmg = 0
	dmg_run = DMGEffectRuntime.new(dmg_res)
	
	name_id = "Poison"
	triggers = [Constants.Trigger.TURN_END]

func apply(target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % [target, self])
		return
	
	# Increase DMG until it reaches stacks
	if dmg_run.dmg < stacks:
		dmg_run.dmg += 1

	# Make sure DMG is capped at stacks	
	if dmg_run.dmg > stacks:
		dmg_run.dmg = stacks

	Console.print_line("* [%s] was afflicted by [%s]" % [target, self])
	dmg_run.apply(source, target)

	Console.print_line("* [%s] stacks remaining: [%s]" % [self, stacks])
