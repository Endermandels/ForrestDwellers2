extends Node
# Global

## Returns max([num], 0)
func clamp_zero(num: int) -> int:
    return max(num, 0)

## Returns [num] <= 0
func stat_is_depleted(num: int) -> bool:
    return num <= 0