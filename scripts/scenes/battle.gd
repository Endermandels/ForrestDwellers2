extends Node2D
class_name Battle

@export var auto_step_timer: Timer
@export var battle_handler: BattleHandler
@export var battlefield_handler: BattlefieldHandler

## Command: Array of strings associated with said command
const COMMANDS = {
	"step": ["step", "s"],					# Advance the simulation
	"quit": ["exit", "quit"],				# Quit the game
	"clear": ["clear"],						# Clear the Console
	"battlefield": ["battlefield", "bf"],	# Print the current state of the battlefield
	"auto": ["auto", "a"],					# Toggle auto step in the Console
	"speed": ["speed", "spd"],				# Change the auto step period (param1 = period)
	"stats": ["stats", "st"],				# Check the stats of a unit (param1 = row, param2 = col)
	"left": ["left", "l"],					# Move the player's selection of defender left
	"right": ["right", "r"],					# Move the player's selection of defender right
	"confirm": ["confirm", "c"],			# Confirm the player's selection of defender
}

func print_unit_stats(row: int, col: int) -> void:
	var unit: UnitRuntime = battlefield_handler.battlefield[Helper.get_pos(row, col)]
	if unit:
		Console.print_line("=> %s" % unit)
		Console.print_line("=> HP:    %d/%d"  % [unit.hp, unit.base_hp])
		Console.print_line("=> ATK:   %d/%d" % [unit.atk, unit.base_atk])
		Console.print_line("=> ARM:   %d/%d" % [unit.arm, unit.base_arm])
		Console.print_line("=> SPD:   %d/%d" % [unit.spd, unit.base_spd])
		Console.print_line("=> MP:    %d/%d"  % [unit.mp, unit.base_mp])
		Console.print_line("=> ITM:   %d/%d" % [0, unit.itm])
		if unit.status_effects.size() > 0:
			Console.print_line("=> STATUS EFFECTS:")
			for se: StatusEffectRuntime in unit.status_effects:
				Console.print_line("=> [%s] [%d]" % [se, se.stacks])

func _ready() -> void:
	auto_step_timer.timeout.connect(battle_handler.step)
	if Console.visible:
		Console.grab_focus_custom()

func _process(delta: float) -> void:
	var command: String = ""
	var command_prms: PackedStringArray

	if Input.is_action_just_pressed("console"):
		Console.toggle()

	if Console.visible:
		command_prms = Console.get_command().split(" ")
		command = command_prms[0]
	else:
		if Input.is_action_just_pressed("select"): # TODO: Add animation check
			command = COMMANDS.step[0]
		if Input.is_action_just_pressed("cancel"):
			command = COMMANDS.quit[0]

	if command != "":
		if command in COMMANDS.step:
			battle_handler.step()
		elif command in COMMANDS.quit:
			get_tree().quit()
		elif command in COMMANDS.clear:
			Console.clear()
		elif command in COMMANDS.battlefield:
			battlefield_handler.print_battlefield()
		elif command in COMMANDS.auto:
			if auto_step_timer.is_stopped():
				auto_step_timer.start()
			else:
				auto_step_timer.stop()
		elif command in COMMANDS.speed:
			if command_prms.size() > 1 and command_prms[1].is_valid_float():
				auto_step_timer.wait_time = float(command_prms[1])
			else:
				push_warning("! Specify auto step period as a float")
				Console.print_line("! Specify auto step period as a float", Color.RED)
		elif command in COMMANDS.stats:
			if command_prms.size() > 2 and command_prms[1].is_valid_int() and command_prms[2].is_valid_int():
				print_unit_stats(int(command_prms[1]), int(command_prms[2]))
			else:
				push_warning("! Specify unit row and col")
				Console.print_line("! Specify unit row and col", Color.RED)
		elif command in COMMANDS.left:
			battle_handler.player_move_selection(true)
		elif command in COMMANDS.right:
			battle_handler.player_move_selection(false)
		elif command in COMMANDS.confirm:
			battle_handler.player_confirm_selection()
		else:
			push_warning("! Invalid command: '%s'" % command)
			Console.print_line("! Invalid command: '%s'" % command, Color.RED)
