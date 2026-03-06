extends Node2D
class_name MainMenu

@export_file_path("*.tscn") var battle_scene_path: String

func _init() -> void:
	GameState.init_new_game()

func _ready() -> void:
	print("~~~ Main Menu ~~~")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"):
		get_tree().change_scene_to_file(battle_scene_path)
