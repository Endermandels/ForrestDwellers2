extends Resource
class_name StatusEffectResource

@export_placeholder("Poison") var name_id: String = ""
@export_range(0, 99999999999999) var stacks: int = 1 ## How many stacks are left
@export var target_rule: Constants.TargetRule = Constants.TargetRule.SELF
@export var triggers: Array[Constants.Trigger] = [Constants.Trigger.TURN_START]
