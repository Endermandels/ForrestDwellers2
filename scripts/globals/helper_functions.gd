extends Node
# Global

## Returns max([num], 0)
func clamp_zero(num: int) -> int:
	return max(num, 0)

## Get position equivalent of row, col
func get_pos(row: int, col: int, columns: int = Constants.BF_COLS) -> int:
	return row * columns + col

## Get row based on [pos] and [columns]
func get_row(pos: int, columns: int = Constants.BF_COLS) -> int:
	return pos / columns

## Get column based on [pos] and [columns]
func get_col(pos: int, columns: int = Constants.BF_COLS) -> int:
	return pos % columns

## Returns whether the [row] is a backline row
func is_backline_row(row: int) -> bool:
	return (row == Constants.BF_PLAYER_BACKLINE_ROW) or (row == Constants.BF_ENEMY_BACKLINE_ROW)

## Returns all valid targets across from source
func _get_valid_targets_across(source: UnitRuntime, bf: Array[UnitRuntime]) -> Array[UnitRuntime]:
	var res: Array[UnitRuntime] = []
	var cols: int = Constants.BF_COLS
	var rows: int = Constants.BF_ROWS
	var src_row: int = get_row(source.position, cols)
	var src_col: int = get_col(source.position, cols)
	var dir: int = 1 if source.is_enemy else -1 ## Which direction to check for enemies from
	var blocked_by_ally: bool = false

	# Backline units must have the space in front of them clear of allies in order to target enemies
	if source.is_backline:
		var ally_in_front: UnitRuntime = bf[Helper.get_pos(src_row + dir, src_col)]
		blocked_by_ally = (ally_in_front != null) and ally_in_front.blocks_backline

	# Identify valid targets
	if not blocked_by_ally:
		for col in range(cols):
			for r in range(rows):
				var row: int = src_row + r * dir # Traverse up or down depending on whether the source is an ally or an enemy
				
				# Check for out of bounds row
				if row < 0 or row >= rows:
					break # Continue to the next column

				var pos: int = Helper.get_pos(row, col)
				var target: UnitRuntime = bf[pos]
				
				if target and target != source:
					if source.is_backline and source.is_enemy == target.is_enemy and target.blocks_backline:
						# Applies when the source is a backline unit
						# Any allied units in this column that aren't the source block the source's way of attack
						break # Continue to the next column
					elif source.is_enemy != target.is_enemy and not target.is_dead:
						res.append(target)
						break # Continue to the next column

	return res

## Get targets using [source] [target_rule] on the battlefield [bf]
func get_targets(source: UnitRuntime, target_rule: Constants.TargetRule, bf: Array[UnitRuntime]) -> Array[UnitRuntime]:
	var res: Array[UnitRuntime] = []

	if target_rule == Constants.TargetRule.SELF:
		res.append(source)

	elif target_rule == Constants.TargetRule.OPPONENT_ENGAGED:
		res.append(source.engaged_opponent)

	elif target_rule == Constants.TargetRule.OPPONENT_ACROSS:
		var valid_flank_targets: Array[UnitRuntime] = [] ## Valid targets to the left or right of source
		var valid_direct_targets: Array[UnitRuntime] = [] ## Valid targets in front of source
		var valid_targets = _get_valid_targets_across(source, bf)

		# Separate direct from flanking units
		for t: UnitRuntime in valid_targets:
			if get_col(t.position) == get_col(source.position):
				valid_direct_targets.append(t)
			else:
				valid_flank_targets.append(t)

		# Add valid targets to results
		if valid_direct_targets.size() > 0:
			res.append(valid_direct_targets.pick_random())
		elif valid_flank_targets.size() > 0:
			res.append(valid_flank_targets.pick_random())

	elif target_rule == Constants.TargetRule.ALL_OPPONENTS_ACROSS:
		res = _get_valid_targets_across(source, bf)

	elif target_rule == Constants.TargetRule.OPPONENT_HIGHEST_HP:
		var valid_targets = _get_valid_targets_across(source, bf)
		if valid_targets.size() > 0:
			valid_targets.sort_custom(func (x: UnitRuntime, y: UnitRuntime): return x.hp > y.hp)
			res.append(valid_targets[0])
	
	elif target_rule == Constants.TargetRule.ALL_OPPONENTS:
		for u: UnitRuntime in bf:
			if u != null and not u.is_dead and u.is_enemy != source.is_enemy:
				res.append(u)
	
	elif target_rule == Constants.TargetRule.ALL_ALLIES:
		for u: UnitRuntime in bf:
			if u != null and not u.is_dead and u.is_enemy == source.is_enemy:
				res.append(u)

	else:
		push_error("Unimplemented Target Rule: " + Constants.TargetRule.keys()[target_rule])

	return res
