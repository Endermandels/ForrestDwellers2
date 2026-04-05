extends RefCounted
class_name AbilityRuntime

var name_id: String
var triggers: Array[Constants.Trigger]
var conditions: Array[AbilityConditionRuntime]
var effects: Array[EffectRuntime]

var source_unit: UnitRuntime ## Source Unit of this Ability

func _init(res: AbilityResource, source: UnitRuntime) -> void:
	name_id = res.name_id
	triggers = res.triggers
	source_unit = source
	
	for e in res.effects:
		var runtime = EffectRuntime.from_resource(e)

		effects.append(runtime)
	
	for c in res.conditions:
		var runtime = AbilityConditionRuntime.new(c)

		conditions.append(runtime)

func _to_string() -> String:
	return name_id
