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
	"speed": ["speed", "spd"]				# Change the auto step period (param1 = period)
}

func _ready() -> void:
	auto_step_timer.timeout.connect(battle_handler.step)

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
			if command_prms.size() > 1:
				auto_step_timer.wait_time = float(command_prms[1])
			else:
				push_warning("! Specify auto step period as a float")
				Console.print_line("! Specify auto step period as a float", Color.RED)
		else:
			push_warning("! Invalid command: '%s'" % command)
			Console.print_line("! Invalid command: '%s'" % command, Color.RED)
