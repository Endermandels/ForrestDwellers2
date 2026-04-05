extends State
class_name StateBattleStart

@export var turn_start_state: State
@export var ability_resolution_state: State

func step(data: BattleStateData) -> State:
	# Trigger Battle Start abilities
	for u: UnitRuntime in data.units_queue:
		assert(not u.is_dead, "Can't start the battle with dead units")
		data.trigger_unit_abilities(u, Constants.Trigger.BATTLE_START)

	data.next_state = turn_start_state
	return ability_resolution_state

func enter(data: BattleStateData) -> void:
	print("* Entered Battle Start State")
	assert(data.units_queue.size() > 1, "There should be at least two units on the field at Battle Start")

	Console.print_line("# Battle Start #", Color.GREEN)
	data.units_queue.sort_custom(func (a: UnitRuntime, b: UnitRuntime): return a.spd > b.spd)

	# TODO: Polish this up somehow (used for setting up first turn because Turn Start State calls data.next_unit on enter)
	data.units_queue.push_front(data.units_queue.pop_back())

func exit(data: BattleStateData) -> void:
	pass
