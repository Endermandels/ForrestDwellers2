extends Resource
class_name AbilityResource

@export_placeholder("Venom") var name_id: String = ""
@export var triggers: Array[Constants.Trigger] = [] ## Triggers to activate this ability
@export var conditions: Array[AbilityConditionResource] = [] ## Extra conditions to activate this ability
@export var effects: Array[EffectResource] = [] ## Effects to apply