extends Node2D
class_name Battle

@export var battle_handler: BattleHandler
@export var battlefield_handler: BattlefieldHandler

## Command: Array of strings associated with said command
const COMMANDS = {
	"step": ["step", "s"],
	"quit": ["exit", "quit"],
	"clear": ["clear"],
	"battlefield": ["battlefield", "bf"]
}

func _process(delta: float) -> void:
	var command: String = ""

	if Input.is_action_just_pressed("console"):
			Console.toggle()

	if Console.visible:
		command = Console.get_command()
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
		else:
			push_warning("Invalid command: '%s'" % command)
			Console.print_line("! Invalid command: '%s'" % command, Color.RED)
