extends RefCounted
class_name StatusEffectRuntime

var name_id: String # TODO: Set appropriately
var stacks: int
var triggers: Array[Constants.Trigger]

var source: UnitRuntime ## Source of status effect

# TODO: Expand as necessary

static func from_resource(res: StatusEffectResource, _source: UnitRuntime) -> StatusEffectRuntime:
	if res is StatusEffectPoisonResource:
		return StatusEffectPoisonRuntime.new(res, _source)
	if res is StatusEffectWeaknessResource:
		return StatusEffectWeaknessRuntime.new(res, _source)
	if res is StatusEffectTerrorResource:
		return StatusEffectTerrorRuntime.new(res, _source)
	push_error("No runtime registered for: %s" % res.get_class())
	return StatusEffectRuntime.new(res, _source)

func _init(res: StatusEffectResource, _source: UnitRuntime = null) -> void:
	stacks = res.stacks
	source = _source

	# Set by each subclass
	name_id = "" 
	triggers = []
	
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
