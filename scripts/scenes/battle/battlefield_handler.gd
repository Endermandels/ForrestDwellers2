extends Node
class_name BattlefieldHandler

# 4 Rows, 2 for Enemies, 2 for Allies
## Array of units on a 2D battlefield (null for an empty space). Example: 
##[br]   (0) null,      (1) Raven,  (2) null   = enemy backline
##[br]   (3) Wolf,      (4) Snake,  (5) null   = enemy frontline
##[br]   (6) Porcupine, (7) Player, (8) null   = player frontline
##[br]   (9) Raven,     (10) null,  (11) Rabbit = player backline
##[br] Every unit occupies exactly one space
var battlefield: Array[UnitRuntime]

func _init() -> void:
	# Initialize with all nulls (4 rows)
	for r in range(Constants.BF_ROWS * Constants.BF_COLS):
		battlefield.append(null)

func add_unit(unit: UnitRuntime) -> void:
	var row: int = Helper.get_row(unit.position)
	var col: int = Helper.get_col(unit.position)
	var pos = unit.position

	assert(battlefield[pos] == null, "Battlefield space R%dC%d occupied by [%s]!" % [row, col, battlefield[pos]])
	battlefield[pos] = unit

func print_battlefield(include_stats: bool = true) -> void:
	for row in range(Constants.BF_ROWS):
		var line = " | "
		for col in range(Constants.BF_COLS):
			var unit: UnitRuntime = battlefield[Helper.get_pos(row, col)]
			var unit_str: String = unit.name_id if unit != null else "EMPTY"
			line += "%s | " % unit_str
		Console.print_line(line)
		if include_stats:
			line = " | "
			for col in range(Constants.BF_COLS):
				var unit: UnitRuntime = battlefield[Helper.get_pos(row, col)]
				var unit_stats: String = "N/A" if unit == null else "%d/%d/%d/%d/%d" % [unit.hp, unit.arm, unit.atk, unit.spd, unit.mp]
				line += "%s | " % unit_stats
			Console.print_line(line)

