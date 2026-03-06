extends State
class_name StateBattleEnd

func step(data: Dictionary) -> State:
	return null

func enter(data: Dictionary) -> void:
	print("~~~ Battle End ~~~")
	if data.player_won:
		print("* Player Won!")
	else:
		print("* Game Over")

func exit(data: Dictionary) -> void:
	pass
