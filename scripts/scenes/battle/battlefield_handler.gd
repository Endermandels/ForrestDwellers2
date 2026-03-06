extends Node
class_name BattlefieldHandler

@export var columns: int = 3 ## How many columns in each row
# 4 Rows, 2 for Enemies, 2 for Allies

## Array of units on a 2D battlefield (null for an empty space). Example: 
##[br]   (0) null,      (1) Raven,  (2) null   = enemy backline
##[br]   (3) Wolf,      (4) Snake,  (5) null   = enemy frontline
##[br]   (6) Porcupine, (7) Player, (8) null   = player frontline
##[br]   (9) Raven,     (10) null,  (11) Rabbit = player backline
##[br] Some units are big (like the dragon) and thus need to be able to take up multiple spaces
var battlefield: Array[UnitRuntime]

func _init() -> void:
	# Initialize with all nulls (4 rows)
	for r in range(4 * columns):
		battlefield.append(null)

func add_unit(unit: UnitRuntime) -> void:
	var col_off: int = unit.position % columns
	var row_off: int = unit.position / columns

	for r in range(unit.battlefield_length):
		for c in range(unit.battlefield_width):
			var row = row_off + r
			var col = col_off + c
			var pos = Helper.get_pos(row, col, columns)

			assert(battlefield[pos] == null, "Battlefield space R%dC%d occupied by [%s]!" % [row, col, battlefield[pos]])
			battlefield[pos] = unit

## Get targets using [source] [target_rule] on the battlefield [bf]
static func get_targets(target_rule: Constants.TargetRule, source: UnitRuntime, bf: Array[UnitRuntime]) -> Array[UnitRuntime]:
	var res: Array[UnitRuntime] = []
	var cols: int = bf.size() / 4 # 4 rows of columns

	if target_rule == Constants.TargetRule.OPPONENT_ENGAGED:
		res.append(source.engaged_opponent)
	elif target_rule == Constants.TargetRule.OPPONENT_ACROSS:
		var row_col_pos: Array[int] = Helper.get_row_col(source.position, cols)
		var blocked_by_ally: bool = false
		var valid_targets: Array[UnitRuntime] = []
		
		for c in range(source.battlefield_width):
			var col: int = row_col_pos[1] + c
			var start_looking_for_enemy: bool = false

			for r in range(4):
				var row: int = r if source.is_enemy else (3 - r) # Start on whichever end the source is from
				var pos: int = Helper.get_pos(row, col, cols)
				var target: UnitRuntime = bf[pos]

				if target:
					if target == source:
						# Mark that it is time to start looking for the enemy
						start_looking_for_enemy = true
					elif target.is_enemy == source.is_enemy and start_looking_for_enemy:
						# If in looking for the enemy, instead an ally is found, attack is blocked by default
						blocked_by_ally = true
						break
					elif target.is_enemy != source.is_enemy and start_looking_for_enemy:
						valid_targets.append(target)
						break # Get the first valid target. Ignore backline targets if there is a frontline target
			
			if blocked_by_ally:
				break
		
		if not blocked_by_ally and valid_targets.size() > 0:
			res.append(valid_targets.pick_random())
	else:
		push_error("Unimplemented Target Rule: " + Constants.TargetRule.keys()[target_rule])
	return res
