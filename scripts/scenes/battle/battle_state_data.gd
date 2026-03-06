extends StateData
class_name BattleStateData

var units_queue: Array[UnitRuntime] = []
var defenders_queue: Array[UnitRuntime] = []
var abilities_queue: Array[AbilityRuntime] = []
var battlefield: Array[UnitRuntime] = []

var next_state: State = null
var player_won: bool = false