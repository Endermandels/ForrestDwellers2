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

func apply(battlefield: Array[UnitRuntime]) -> void:
	var all_conditions_met = true

	for c in conditions:
		if not c.is_met(source_unit, battlefield):
			all_conditions_met = false
			break
	
	if all_conditions_met:
		Console.print_line("* [%s] used [%s]" % [source_unit, self])
		for e in effects:
			var targets = Helper.get_targets(source_unit, e.target_rule, battlefield)

			for u in targets:
				e.apply(source_unit, u)
	else:
		Console.print_line("* [%s] could not use [%s]" % [source_unit, self])
