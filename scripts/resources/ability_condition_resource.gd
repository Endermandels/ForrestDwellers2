@tool
extends Resource
class_name AbilityConditionResource

@export var left_units: Constants.TargetRule = Constants.TargetRule.SELF ## Which units to compare on the left side
@export var left_stats: Constants.UnitStat = Constants.UnitStat.MP ## What stats to look at for each unit on the left side
@export var condition_type: Constants.AbiltiyConditionType = Constants.AbiltiyConditionType.SCALAR: ## What to use on the right side
	set(val):
		condition_type = val
		notify_property_list_changed()
@export var operation: Constants.AbilityConditionOperation = Constants.AbilityConditionOperation.GREATER ## How to compare the left side to the right side

@export_group("Boolean")
@export var boolean: bool = false ## A boolean value on the right side
@export_group("Scalar")
@export var scalar: int = 0 ## A scalar value on the right side
@export_group("Units")
@export var right_units: Constants.TargetRule = Constants.TargetRule.SELF ## Which units to compare on the right side
@export var right_stats: Constants.UnitStat = Constants.UnitStat.MP ## What stats to look at for each unit on the right side

func _validate_property(property: Dictionary) -> void:
	if property.name == "Boolean":
		if condition_type != Constants.AbiltiyConditionType.BOOLEAN:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "boolean":
		if condition_type != Constants.AbiltiyConditionType.BOOLEAN:
			property.usage = PROPERTY_USAGE_NO_EDITOR

	if property.name == "Scalar":
		if condition_type != Constants.AbiltiyConditionType.SCALAR:
			property.usage = PROPERTY_USAGE_NO_EDITOR
			
	if property.name == "scalar":
		if condition_type != Constants.AbiltiyConditionType.SCALAR:
			property.usage = PROPERTY_USAGE_NO_EDITOR

	if property.name == "Units":
		if condition_type != Constants.AbiltiyConditionType.UNITS:
			property.usage = PROPERTY_USAGE_NO_EDITOR
			
	if property.name == "right_units":
		if condition_type != Constants.AbiltiyConditionType.UNITS:
			property.usage = PROPERTY_USAGE_NO_EDITOR
			
	if property.name == "right_stats":
		if condition_type != Constants.AbiltiyConditionType.UNITS:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name == "operation":
		if condition_type == Constants.AbiltiyConditionType.BOOLEAN:
			property.usage = PROPERTY_USAGE_NO_EDITOR