extends StateData
class_name BattleStateData

const DEATH_CRY = preload("res://resources/abilities/universal/death_cry.tres")

var units_queue: Array[UnitRuntime] = []
var defenders_queue: Array[UnitRuntime] = []
var abilities_queue: Array[AbilityRuntime] = []
var status_effects_queue: Array[StatusEffectRuntime] = []
var effects_queue: Array[Callable] = [] ## Preload each effect's apply method with a source and target
var battlefield: Array[UnitRuntime] = []

var next_state: State = null ## The state to transition to at the end of the current state
var player_won: bool = false ## Whether the player has won the battle

# Player input data
var player_confirm_selection: bool = false ## Set to true to indicate player has confirmed selection
var player_selected_target: int = 0 ## Which valid target the player is currently choosing to attack
var player_valid_targets: Array[UnitRuntime] = [] ## The valid targets available for the player to attack

#region Common State Functions
## Returns true on reaching an end state, false otherwise. Sets player_won.
func is_end_state() -> bool:
	var reached_end: bool = false

	# Check Battle End States
	if GameState.player.is_dead:
		reached_end = true
		player_won = false
	else:
		var no_enemies_left: bool = true

		# Check whether there are any alive enemies left
		for u: UnitRuntime in units_queue:
			if u.is_enemy and not u.is_dead:
				no_enemies_left = false
				break

		if no_enemies_left:
			reached_end = true
			player_won = true

	return reached_end

## Reset the current unit's modifiers.
## Move the current unit to the end of the units_queue.
func next_unit() -> void:
	# Move current unit to back of queue
	var cur_unit = units_queue.pop_front()

	units_queue.append(cur_unit)

	# Reset Modifiers
	cur_unit.weakness = 0
	cur_unit.strength = 0
	cur_unit.fear = 0
	cur_unit.is_stunned = false

## Triggers On Death abilities and clears status effects for dead units.
## Returns whether there a unit was found to be freshly dead.
func handle_deaths() -> bool:
	var fresh_death: bool = false

	for unit in units_queue:
		if unit.is_dead and not unit.death_has_been_handled:
			var death_cry_res = DEATH_CRY.duplicate()
			var death_cry_run = AbilityRuntime.new(death_cry_res, unit)

			unit.death_has_been_handled = true
			fresh_death = true

			# Trigger Death Cry
			abilities_queue.append(death_cry_run)

			# Trigger ON_DEATH abilities
			trigger_unit_abilities(unit, Constants.Trigger.ON_DEATH)

			# Dead units cannot have status effects
			unit.status_effects.clear()
			status_effects_queue.clear()

	return fresh_death

## Activate all unit abilities for the given trigger.
## Returns whether any abilities were triggered.
func trigger_unit_abilities(unit: UnitRuntime, trigger: Constants.Trigger) -> bool:
	var ability_triggered: bool = false

	for a: AbilityRuntime in unit.abilities_dict[Constants.Trigger.keys()[trigger]]:
		abilities_queue.append(a)
		ability_triggered = true

	return ability_triggered

## Activate all unit status effects for the given trigger.
## Returns whether any status effects were triggered.
func trigger_status_effects(unit: UnitRuntime, trigger: Constants.Trigger) -> bool:
	var status_effect_triggered: bool = false

	for se: StatusEffectRuntime in unit.status_effects:
		if trigger in se.triggers:
			status_effects_queue.append(se)
			status_effect_triggered = true
	
	return status_effect_triggered

#endregion