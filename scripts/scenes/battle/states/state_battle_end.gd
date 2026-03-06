extends State
class_name StateBattleEnd

func step(data: BattleStateData) -> State:
	return null

func enter(data: BattleStateData) -> void:
	print("~~~ Battle End ~~~")
	if data.player_won:
		print("* Player Won!")
	else:
		print("* Game Over")

func exit(data: BattleStateData) -> void:
	pass
