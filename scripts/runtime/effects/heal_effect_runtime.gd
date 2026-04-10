extends EffectRuntime
class_name HEALEffectRuntime

var heal: int ## How much HEAL to apply

func init(res: HEALEffectResource) -> void:
	name_id = "HEAL"
	heal = res.heal

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return
	
	Console.print_line("* [%s] healed [%d]" % [target, heal])
	
	# Clamp HP <= Base HP
	target.hp = min(target.hp + heal, target.base_hp)

	Console.print_line("* [%s] is at [%d] HP" % [target, target.hp])
