extends RefCounted
class_name AbilityConditionRuntime

var left_units: Constants.TargetRule ## Which units to compare on the left side
var left_stats: Constants.UnitStat ## What stats to look at for each unit on the left side
var operation: Constants.AbilityConditionOperation ## How to compare the left side to the right side
var condition_type: Constants.AbiltiyConditionType ## What to use on the right side
var boolean: bool ## A boolean value on the right side
var scalar: int ## A scalar value on the right side
var right_units: Constants.TargetRule ## Which units to compare on the right side
var right_stats: Constants.UnitStat ## What stats to look at for each unit on the right side

func _init(res: AbilityConditionResource) -> void:
	left_units = res.left_units
	left_stats = res.left_stats
	operation = res.operation
	condition_type = res.condition_type
	boolean = res.boolean
	scalar = res.scalar
	right_units = res.right_units
	right_stats = res.right_stats

func _get_stat(unit: UnitRuntime, stat: Constants.UnitStat):
	var res = -1

	if stat == Constants.UnitStat.MP:
		res = unit.mp
	elif stat == Constants.UnitStat.ARM:
		res = unit.arm
	elif stat == Constants.UnitStat.ARMORED_DEFENSE:
		res = unit.armored_defense
	else:
		push_error("! Unknown unit stat: [%s]" % stat)
	
	return res

func _comp(left: int, right: int) -> bool:
	var res = false
	
	if operation == Constants.AbilityConditionOperation.EQUALS:
		res = left == right
	elif operation == Constants.AbilityConditionOperation.GREATER:
		res = left > right
	elif operation == Constants.AbilityConditionOperation.LESSER:
		res = left < right
	else:
		push_error("! Unknown operation: [%s]" % operation)

	return res

func is_met(source: UnitRuntime, battlefield: Array[UnitRuntime]) -> bool:
	var met = true
	var left_units_run: Array[UnitRuntime] = Helper.get_targets(source, left_units, battlefield)

	if condition_type == Constants.AbiltiyConditionType.BOOLEAN:
		for u: UnitRuntime in left_units_run:
			if _get_stat(u, left_stats) != boolean:
				met = false
				break
	elif condition_type == Constants.AbiltiyConditionType.SCALAR:
		for u: UnitRuntime in left_units_run:
			if not _comp(_get_stat(u, left_stats), scalar):
				met = false
				break
	elif condition_type == Constants.AbiltiyConditionType.UNITS:
		var right_units_run: Array[UnitRuntime] = Helper.get_targets(source, right_units, battlefield)

		for lu: UnitRuntime in left_units_run:
			for ru: UnitRuntime in right_units_run:
				if not _comp(_get_stat(lu, left_stats), _get_stat(ru, right_stats)):
					met = false
					break
			if not met:
				break
	else:
		push_error("! Unknown ability condition type: [%s]" % condition_type)
		met = false

	return met
