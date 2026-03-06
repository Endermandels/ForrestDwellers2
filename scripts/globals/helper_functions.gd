extends Node
# Global

## Returns max([num], 0)
func clamp_zero(num: int) -> int:
	return max(num, 0)

## Returns [num] <= 0
func stat_is_depleted(num: int) -> bool:
	return num <= 0

## Get position equivalent of row, col
func get_pos(row: int, col: int, columns: int) -> int:
	return row * columns + col

## Get row, col equivalent of position
func get_row_col(pos: int, columns: int) -> Array[int]:
	return [pos / columns, pos % columns]
