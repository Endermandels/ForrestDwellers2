extends EffectRuntime
class_name AddAbilityRuntime

var from_enemy: bool
var ability_res: AbilityResource

func init(res: AddAbilityResource) -> void:
	from_enemy = res.from_enemy
	ability_res = res.ability
	name_id = "Add Ability Effect"

# Source is always the ability holder, so target must be the enemy
func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return
	
	if not from_enemy:
		var ability_run: AbilityRuntime = AbilityRuntime.new(ability_res, source)
		var found_ability: bool = target.abilities.any(func (a: AbilityRuntime): return a.name_id == ability_run.name_id)
		
		if not found_ability:
			Console.print_line("* [%s] gained [%s]" % [target, ability_run])
			target.add_ability(ability_run)
		else:
			Console.print_line("* [%s] already has [%s]" % [target, ability_run])
	else:
		# Find all abilities that this unit can get from the enemy (source)
		var valid_abilities: Array[AbilityRuntime] = []
		
		for a: AbilityRuntime in source.abilities:
			if not target.abilities.any(func (ab: AbilityRuntime): return ab.name_id == a.name_id):
				# Target doesn't have the ability
				valid_abilities.append(a)
		
		if valid_abilities.size() > 0:
			var ability: AbilityRuntime = valid_abilities.pick_random()

			Console.print_line("* [%s] gained [%s] from [%s]" % [target, ability, source])
			target.add_ability(ability.duplicate(target))
		else:
			Console.print_line("* [%s] cannot gain abilities from [%s]" % [target, source])
