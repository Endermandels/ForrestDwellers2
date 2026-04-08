extends RefCounted
class_name UnitRuntime

# Runtime Data
var name_id: String
var attack_target_rule: Constants.TargetRule ## TargetRule for choosing defenders of this unit's attack
var position: int: ## The battle field index this unit occupies
	set(val):
		position = val
		is_backline = Helper.is_backline_row(Helper.get_row(val)) # Set the is_backline flag automatically

# Arrays
var abilities_dict: Dictionary[String, Array] ## Constants.Trigger: Array of Abilities
var abilities: Array[AbilityRuntime] ## All abilities associated with this unit
var status_effects: Array[StatusEffectRuntime] ## Active status effects

# Stats
var base_hp: int
var base_atk: int
var base_arm: int
var base_spd: int
var base_mp: int
var hp: int:
	set(val):
		hp = val
		if hp <= 0:
			is_dead = true
			blocks_backline = false
var atk: int
var arm: int
var spd: int
var mp: int
var itm: int

# Boolean attributes
var is_dead: bool ## Whether this unit is dead
var is_enemy: bool ## Whether this unit is an enemy of the player or not
var is_backline: bool ## Whether this unit is currently in the backlines
var blocks_backline: bool: ## Whether this unit blocks backline units from attacking
	get():
		return not is_dead and not is_flying
var death_has_been_handled: bool ## Whether this unit's death has been handled (On Death triggering, Game State checking, etc.)

# Attack Specific
var armored_defense: bool ## Whether this unit defended with ARM > 0
var full_health_defense: bool ## Whether this unit defended with HP == BASE_HP
var engaged_opponent: UnitRuntime ## The opponent this unit is currently engaged in combat with

# Modifiers (cleared at Turn End)
var weakness: int ## Decrease ATK
var strength: int ## Increase ATK
var fear: int ## Chance to run away
var is_flying: bool: ## Whether this unit has the Flying Passive Ability
	get():
		return Helper.unit_has_passive(self, Constants.PassiveAbility.FLYING)
var is_stunned: bool ## Whether this unit should skip its attack

func _init(res: UnitResource) -> void:
	# Resource-specific
	name_id = res.name_id
	attack_target_rule = res.attack_target_rule
	base_hp = res.base_hp
	base_atk = res.base_atk
	base_arm = res.base_arm
	base_spd = res.base_spd
	base_mp = res.base_mp
	itm = res.itm

	# Runtime-specific
	hp = base_hp
	atk = base_atk
	arm = base_arm
	spd = base_spd
	mp = base_mp

	weakness = 0
	strength = 0
	fear = 0

	is_enemy = true
	is_flying = false
	death_has_been_handled = false
	blocks_backline = true
	position = 0

	abilities_dict = {}
	abilities = []

	for t in Constants.Trigger.keys():
		abilities_dict[t] = []

	for a in res.abilities:
		var runtime = AbilityRuntime.new(a, self)

		abilities.append(runtime)
		for t in runtime.triggers:
			abilities_dict[Constants.Trigger.keys()[t]].append(runtime)

func _to_string() -> String:
	return "%s @ (R%d, C%d)" % [name_id + (" Corpse" if is_dead else ""), Helper.get_row(position), Helper.get_col(position)]
