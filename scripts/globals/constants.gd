extends Node
# Global

enum Trigger {
	BATTLE_START,
	TURN_START,
	TURN_END,
	ON_HIT,
	ON_HURT,
	ON_DEATH,
	ON_WOUNDED,
	ON_WOUNDED_BY_HURT,
	PASSIVE,
}

enum TargetRule {
	SELF, ## This unit
	OPPONENT_ACROSS, ## Opponent directly opposing this unit
	OPPONENT_ENGAGED, ## Opponent this unit is in combat with
	ALL_OPPONENTS, ## All opposing units
	ALL_ALLIES, ## All allied units
	ALL, ## All units
}

## Nunber of rows in the battlefield
const BF_ROWS = 4
## Number of columns in the battlefield
const BF_COLS = 3
const BF_ENEMY_BACKLINE_ROW = 0
const BF_ENEMY_FRONTLINE_ROW = 1
const BF_PLAYER_FRONTLINE_ROW = 2
const BF_PLAYER_BACKLINE_ROW = 3