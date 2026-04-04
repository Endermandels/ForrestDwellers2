extends RefCounted
class_name UnitRuntime

# Runtime Data
var name_id: String
var attack_target_rule: Constants.TargetRule ## TargetRule for choosing defenders of this unit's attack
var position: int: ## The battle field index this unit occupies
	set(val):
		position = val
		is_backline = Helper.is_backline_row(Helper.get_row(val)) # Set the is_backline flag automatically
var blocks_backline: bool ## Whether this unit blocks backline units from attacking
var abilities_dict: Dictionary[String, Array] ## Constants.Trigger: Array of Abilities
var abilities: Array[AbilityRuntime] ## All abilities associated with this unit
var status_effects: Array[StatusEffectRuntime] ## Active status effects
var engaged_opponent: UnitRuntime ## The opponent this unit is currently engaged in combat with

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
var is_enemy: bool ## Whether this unit is an enemy of the player or not
var is_dead: bool ## Whether this unit is dead
var is_backline: bool ## Whether this unit is currently in the backlines

# Defense Metrics
var armored_defense: bool ## Whether this unit defended with ARM > 0
var full_health_defense: bool ## Whether this unit defended with HP == BASE_HP

# Modifiers (cleared at Turn End)
var weakness: int ## decrease ATK
var strength: int ## increase ATK
var fear: int ## chance to run away
var is_stunned: bool ## Whether this unit should skip its attack

func _init(res: UnitResource) -> void:
	name_id = res.name_id
	is_enemy = res.is_enemy
	base_hp = res.base_hp
	base_atk = res.base_atk
	base_arm = res.base_arm
	base_spd = res.base_spd
	base_mp = res.base_mp
	itm = res.itm
	hp = base_hp
	atk = base_atk
	arm = base_arm
	spd = base_spd
	mp = base_mp

	weakness = 0
	strength = 0
	fear = 0

	blocks_backline = res.blocks_backline
	attack_target_rule = res.attack_target_rule
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
