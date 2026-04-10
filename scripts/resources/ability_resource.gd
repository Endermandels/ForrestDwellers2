@tool
extends Resource
class_name AbilityResource

var is_passive: bool = false ## Whether this ability is passive

@export_placeholder("Venom") var name_id: String = ""
@export var triggers: Array[Constants.Trigger] = []: ## Triggers to activate this ability
	set(val):
		is_passive = Constants.Trigger.PASSIVE in val
		triggers = val
		notify_property_list_changed()
@export var conditions: Array[AbilityConditionResource] = [] ## Extra conditions to activate this ability
@export var effects: Array[EffectResource] = [] ## Effects to apply
@export var passive: Constants.PassiveAbility = Constants.PassiveAbility.FLYING

func _validate_property(property: Dictionary) -> void:
	if property.name == "passive":
		if not is_passive:
			property.usage = PROPERTY_USAGE_NO_EDITOR
