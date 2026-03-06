extends Resource
class_name AbilityResource

@export_placeholder("Venom") var name_id: String = ""
@export var triggers: Array[Constants.Trigger] = [] ## Triggers to activate this ability
# Conditions (including cost)
@export var effects: Array[EffectResource] = [] ## Effects to apply