extends Resource
class_name UnitResource

@export_placeholder("Wolf") var name_id: String = ""
@export var is_enemy: bool = true
@export var attack_target_rule: Constants.TargetRule = Constants.TargetRule.OPPONENT_ACROSS
@export_range(1, 3) var battlefield_width: int = 1 ## How many columns this unit takes up on the battlefield
@export_range(1, 2) var battlefield_length: int = 1 ## How many rows this unit takes up on the battlefield
@export_group("Base Stats")
@export_range(0, 20) var base_hp: int = 1
@export_range(0, 10) var base_atk: int = 0
@export_range(0, 10) var base_arm: int = 0
@export_range(0, 10) var base_spd: int = 0
@export_range(0, 10) var base_mp: int = 0
@export_range(0, 10) var itm: int = 0 ## How many items this unit can carry
@export_group("Abilities")
@export var abilities: Array[AbilityResource] = []