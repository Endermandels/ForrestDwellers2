extends State
class_name StateBattleEnd

func step(data: BattleStateData) -> State:
	return null

func enter(data: BattleStateData) -> void:
	print("* Entered Battle End State")
	Console.print_line("# Battle End #", Color.GREEN)
	if data.player_won:
		Console.print_line("* Player Won!")
	else:
		Console.print_line("* Game Over")

func exit(data: BattleStateData) -> void:
	pass
