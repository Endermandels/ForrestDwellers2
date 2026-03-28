extends RefCounted
class_name StatusEffectRuntime

var name_id: String
var stacks: int
var target_rule: Constants.TargetRule
var triggers: Array[Constants.Trigger]
var effects: Array[EffectRuntime]

var source: UnitRuntime ## Source of status effect

# TODO: Expand as necessary

static func from_resource(res: StatusEffectResource, _source: UnitRuntime) -> StatusEffectRuntime:
	if res is StatusEffectPoisonResource:
		return StatusEffectPoisonRuntime.new(res, _source)
	push_error("No runtime registered for: %s" % res.get_class())
	return StatusEffectRuntime.new(res, _source)

func _init(res: StatusEffectResource, _source: UnitRuntime = null) -> void:
	name_id = res.name_id
	stacks = res.stacks
	target_rule = res.target_rule
	triggers = res.triggers
	source = _source
	
	for e in res.effects:
		var e_run: EffectRuntime = EffectRuntime.from_resource(e)
		effects.append(e_run)

	init(res)

func _to_string() -> String:
	return name_id

## Override hook called by [method _init] after base fields are populated.
## Subclasses use this to read subtype-specific fields from [param res].
## The caller always passes the concrete resource subtype (e.g. [DMGEffectResource]).
func init(res) -> void:
	# TODO: Implement
	pass

func apply(target: UnitRuntime) -> void:
	# TODO: Implement
	pass
