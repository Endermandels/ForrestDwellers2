extends EffectResource
class_name AddAbilityResource

# ! NOTE: from_enemy should only be set for Scavenger units currently
@export var from_enemy: bool = false: ## Whether the ability is a random ability from the engaged opponent or a static ability
	set(val):
		from_enemy = val
		if val:
			# The Target rule should only be the engaged opponent for the time being
			target_rule = Constants.TargetRule.OPPONENT_ENGAGED
		notify_property_list_changed()
@export var ability: AbilityResource ## The ability to add

func _validate_property(property: Dictionary) -> void:
	if property.name == "ability":
		if from_enemy:
			property.usage = PROPERTY_USAGE_NO_EDITOR
