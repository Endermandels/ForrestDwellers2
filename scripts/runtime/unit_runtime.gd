extends Node # TODO: Extend Saveable
class_name UnitRuntime

# Runtime Data
var name_id: String

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

func _to_string() -> String:
    return name_id
