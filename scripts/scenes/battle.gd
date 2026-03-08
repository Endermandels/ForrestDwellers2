extends Node2D
class_name Battle

@export var battle_handler: BattleHandler

const COMMANDS = {
	"step": "step", "s": "s",
	"exit": "exit", "quit": "quit",
}

func _process(delta: float) -> void:
	var command: String = Console.get_command()
	if command != "" and not command in COMMANDS.keys():
		push_warning("Invalid command: '%s'" % command)
		Console.print_line("! Invalid command: '%s'" % command, Color.RED)

	if Input.is_action_just_pressed("select") or command == COMMANDS.step or command == COMMANDS.s: # TODO: Add animation check
		battle_handler.step()
	if Input.is_action_just_pressed("cancel") or command == COMMANDS.exit or command == COMMANDS.quit:
		get_tree().quit()
	if Input.is_action_just_pressed("console"):
		Console.toggle()
