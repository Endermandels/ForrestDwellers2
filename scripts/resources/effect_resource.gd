extends Resource
class_name EffectResource

@export_placeholder("DMG") var name_id: String = ""
@export_range(0, 99999999999999) var value: int = 1 ## How strong the effect is
@export var target_rule: Constants.TargetRule = Constants.TargetRule.SELF
