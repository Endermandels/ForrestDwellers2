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

	# Add unit's abilities as children of that unit
	for a in unit.abilities:
		unit.add_child(a)

	Console.print_line("* Added unit: [%s]" % unit)

## Handle the next step in the battle
func step() -> void:
	state_machine.step()
