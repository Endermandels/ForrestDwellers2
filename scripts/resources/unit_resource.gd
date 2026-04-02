extends Resource
class_name UnitResource

const DEATH_CRY_RES = preload("res://resources/abilities/death_cry.tres")

@export_placeholder("Wolf") var name_id: String = ""
@export var is_enemy: bool = true ## Whether this unit is an enemy of the player or not
@export var blocks_backline: bool = true ## Whether this unit blocks backline units from attacking
@export var attack_target_rule: Constants.TargetRule = Constants.TargetRule.OPPONENT_ACROSS ## TargetRule for choosing defenders of this unit's attack
@export_group("Base Stats")
@export_range(0, 100) var base_hp: int = 1
@export_range(0, 50) var base_atk: int = 0
@export_range(0, 150) var base_arm: int = 0
@export_range(0, 10) var base_spd: int = 0
@export_range(0, 10) var base_mp: int = 0
@export_range(0, 10) var itm: int = 0 ## How many items this unit can carry
@export_group("Abilities")
@export var abilities: Array[AbilityResource] = [DEATH_CRY_RES]