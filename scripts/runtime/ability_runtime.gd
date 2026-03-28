extends RefCounted
class_name AbilityRuntime

var name_id: String
var triggers: Array[Constants.Trigger]
var effects: Array[EffectRuntime]

var source_unit: UnitRuntime ## Source Unit of this Ability

func _init(res: AbilityResource, source: UnitRuntime) -> void:
	name_id = res.name_id
	triggers = res.triggers
	source_unit = source
	for e in res.effects:
		var runtime = EffectRuntime.from_resource(e)

		effects.append(runtime)

func _to_string() -> String:
	return name_id

func apply(battlefield: Array[UnitRuntime]) -> void:
	for e in effects:
		var targets = Helper.get_targets(source_unit, e.target_rule, battlefield)

		for u in targets:
			e.apply(source_unit, u)
