extends Node2D
class_name Battle

@export var battle_handler: BattleHandler

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("select"): # TODO: Add animation check
		battle_handler.step()
	if Input.is_action_just_pressed("cancel"):
		get_tree().quit()
