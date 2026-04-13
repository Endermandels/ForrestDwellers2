extends EffectRuntime
class_name AddAbilityRuntime

var from_enemy: bool
var ability_res: AbilityResource

func init(res: AddAbilityResource) -> void:
	from_enemy = res.from_enemy
	ability_res = res.ability
	name_id = "Add Ability Effect"

# Source is always the ability holder, so if from_enemy is enabled, the target must be the engaged opponent
func apply(source: UnitRuntime, target: UnitRuntime) -> void:
	if not from_enemy:
		if target.is_dead:
			Console.print_line("* [%s] is dead" % target)
			return

		var ability_run: AbilityRuntime = AbilityRuntime.new(ability_res, source)
		var found_ability: bool = target.abilities.any(func (a: AbilityRuntime): return a.name_id == ability_run.name_id)
		
		if not found_ability:
			Console.print_line("* [%s] gained [%s]" % [target, ability_run])
			target.add_ability(ability_run)
		else:
			Console.print_line("* [%s] already has [%s]" % [target, ability_run])
	else:
		if source.is_dead:
			Console.print_line("* [%s] is dead" % source)
			return
		
		# Find all abilities that this unit (source) can get from the enemy (target)
		var valid_abilities: Array[AbilityRuntime] = []
		
		for a: AbilityRuntime in target.abilities:
			if (
				a.triggers.any(func (t: Constants.Trigger): return not (t in [Constants.Trigger.BATTLE_START])) 	# No Battle Start only Abilities
				and not source.abilities.any(func (ab: AbilityRuntime): return ab.name_id == a.name_id)			# No duplicate Abilities
			):
				valid_abilities.append(a)
		
		if valid_abilities.size() > 0:
			var ability: AbilityRuntime = valid_abilities.pick_random()

			Console.print_line("* [%s] gained [%s] from [%s]" % [source, ability, target])
			source.add_ability(ability.duplicate(source))
		else:
			Console.print_line("* [%s] cannot gain abilities from [%s]" % [source, target])
