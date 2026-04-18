extends Resource
class_name UnitResource

@export_placeholder("Wolf") var name_id: String = ""
@export var attack_target_rule: Constants.TargetRule = Constants.TargetRule.OPPONENT_ACROSS ## TargetRule for choosing defenders of this unit's attack
@export_group("Base Stats")
@export_range(0, 100) var base_hp: int = 1 ## Stay alive
@export_range(0, 50) var base_atk: int = 0 ## Kill stuff
@export_range(0, 150) var base_arm: int = 0 ## Reduce attacks and block body-piercing abilities
@export_range(0, 10) var base_spd: int = 0 ## Go first, leave first
@export_range(0, 10) var base_mp: int = 0 ## Cast abilities
@export_group("Hidden Stats")
@export_range(0, 10) var itm: int = 1 ## Carry more items
@export_range(0, 10) var courage: int = 5 ## Resist Terror, go first among same-speed units
@export_group("Abilities")
@export var abilities: Array[AbilityResource] = []