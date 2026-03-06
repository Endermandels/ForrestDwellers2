extends RefCounted
class_name EffectRuntime

var name_id: String
var value: int
var target_rule: Constants.TargetRule
# TODO: Expand as necessary

static func from_resource(res: EffectResource) -> EffectRuntime:
    if res is DMGEffectResource:
        return DMGEffectRuntime.new(res)
    push_error("No runtime registered for: %s" % res.get_class())
    return EffectRuntime.new(res)

func _init(res: EffectResource) -> void:
    name_id = res.name_id
    value = res.value
    target_rule = res.target_rule
    init(res)

func _to_string() -> String:
    return name_id

## Override hook called by [method _init] after base fields are populated.
## Subclasses use this to read subtype-specific fields from [param res].
## The caller always passes the concrete resource subtype (e.g. [DMGEffectResource]).
func init(res) -> void:
    # TODO: Implement
    pass

func apply(source: UnitRuntime, target: UnitRuntime) -> void:
    # TODO: Implement
    pass