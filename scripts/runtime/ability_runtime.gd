extends RefCounted
class_name AbilityRuntime

var name_id: String
var is_passive: bool
var passive: Constants.PassiveAbility

var triggers: Array[Constants.Trigger]
var conditions: Array[AbilityConditionRuntime]
var effects: Array[EffectRuntime]

var source_unit: UnitRuntime ## Source Unit of this Ability

func _init(res: AbilityResource, source: UnitRuntime) -> void:
	source_unit = source

	name_id = res.name_id
	is_passive = res.is_passive
	passive = res.passive
	triggers = res.triggers
	
	for c in res.conditions:
		var runtime = AbilityConditionRuntime.new(c)

		conditions.append(runtime)
	
	for e in res.effects:
		var runtime = EffectRuntime.from_resource(e)

		effects.append(runtime)

func _to_string() -> String:
	return name_id
