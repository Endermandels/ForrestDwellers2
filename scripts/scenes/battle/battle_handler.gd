extends Node # TODO: Extend Saveable
class_name BattleHandler

@export var state_machine: StateMachine
@export var unit_spawner: UnitSpawner
@export var battlefield_handler: BattlefieldHandler

var data: BattleStateData = null

func _ready() -> void:
	var units = unit_spawner.get_units_to_spawn()

	data = BattleStateData.new()
	data.battlefield = battlefield_handler.battlefield
	
	for u in units:
		add_unit(u)

	state_machine.init(data)

func add_unit(unit: UnitRuntime) -> void:
	# Add unit to battlefield
	battlefield_handler.add_unit(unit)

	# Add unit to queue
	data.units_queue.append(unit)

	Console.print_line("* Added unit: [%s]" % unit)

## Move the player's defender selection to the left or right
func player_move_selection(is_left: bool) -> void:
	data.player_selected_target += -1 if is_left else 1

	# Make sure data.player_selected_target is within the size of the data.player_valid_targets array
	if data.player_selected_target >= data.player_valid_targets.size():
		data.player_selected_target = 0
	if data.player_selected_target < 0:
		data.player_selected_target = data.player_valid_targets.size() - 1
	
	Console.print_line("> Selected [%s] (/c to confirm, /l to move selection left, /r to move selection right)" % data.player_valid_targets[data.player_selected_target])

## Confirm player's defender selection and step the simulation
func player_confirm_selection() -> void:
	data.player_confirm_selection = true
	step()

## Handle the next step in the battle
func step() -> void:
	state_machine.step()
