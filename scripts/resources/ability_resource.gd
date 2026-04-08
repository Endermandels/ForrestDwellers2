@tool
extends Resource
class_name AbilityResource

@export_placeholder("Venom") var name_id: String = ""

@export var is_passive: bool = false: ## Whether this ability is passive
	set(val):
		is_passive = val
		if is_passive:
			triggers = [Constants.Trigger.PASSIVE]
			conditions = []
			effects = []
		else:
			triggers = []
		notify_property_list_changed()

@export var passive: Constants.PassiveAbility = Constants.PassiveAbility.FLYING

@export var triggers: Array[Constants.Trigger] = [] ## Triggers to activate this ability
@export var conditions: Array[AbilityConditionResource] = [] ## Extra conditions to activate this ability
@export var effects: Array[EffectResource] = [] ## Effects to apply

func _validate_property(property: Dictionary) -> void:
	if property.name in ["triggers", "conditions", "effects"]:
		if is_passive:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "passive":
		if not is_passive:
			property.usage = PROPERTY_USAGE_NO_EDITOR
