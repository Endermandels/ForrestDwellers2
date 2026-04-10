extends Node2D
class_name MainMenu

@export_file_path("*.tscn") var battle_scene_path: String

## Command: Array of strings associated with said command
const COMMANDS = {
	"start": ["start", "s"],				# Start new game
	"quit": ["exit", "quit"],				# Quit the game
	"clear": ["clear"],						# Clear the Console
}

func _init() -> void:
	GameState.init_new_game()

func _ready() -> void:
	Console.print_line("# Main Menu #", Color.GREEN)
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
			command = COMMANDS.start[0]
		if Input.is_action_just_pressed("cancel"):
			command = COMMANDS.quit[0]

	if command != "":
		if command in COMMANDS.start:
			get_tree().change_scene_to_file(battle_scene_path)
		elif command in COMMANDS.quit:
			get_tree().quit()
		elif command in COMMANDS.clear:
			Console.clear()
		else:
			push_warning("! Invalid command: '%s'" % command)
			Console.print_line("! Invalid command: '%s'" % command, Color.RED)
