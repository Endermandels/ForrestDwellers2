extends Resource
class_name UnitResource

@export_placeholder("Wolf") var name_id: String = ""
@export var is_enemy: bool = true
@export_group("Base Stats")
@export_range(0, 20) var base_hp: int = 1
@export_range(0, 10) var base_atk: int = 0
@export_range(0, 10) var base_arm: int = 0
@export_range(0, 10) var base_spd: int = 0
@export_range(0, 10) var base_mp: int = 0
@export_range(0, 10) var itm: int = 0 ## How many items this unit can carry