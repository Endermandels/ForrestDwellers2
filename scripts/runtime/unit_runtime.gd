extends Node # TODO: Extend Saveable
class_name UnitRuntime

# Runtime Data
var name_id: String
var is_enemy: bool ## Whether this unit is an enemy of the player or not
var attack_target_rule: Constants.TargetRule ## TargetRule for choosing defenders of this unit's attack
var position: int: ## The battle field index this unit occupies
	set(val):
		position = val
		is_backline = Helper.is_backline_row(Helper.get_row(val)) # Set the is_backline flag automatically
var is_backline: bool ## Whether this unit is currently in the backlines

var abilities_dict: Dictionary[String, Array] ## Constants.Trigger: Array of Abilities
var abilities: Array[AbilityRuntime] ## All abilities associated with this unit
var engaged_opponent: UnitRuntime ## The opponent this unit is currently engaged in combat with


# Stats
var base_hp: int
var base_atk: int
var base_arm: int
var base_spd: int
var base_mp: int
var hp: int
var atk: int
var arm: int
var spd: int
var mp: int
var itm: int

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
	return name_id
