extends Node
# Global

enum Trigger {
	## States

	BATTLE_START,
	TURN_START,
	TURN_END,
	
	## Attack

	ON_HIT,
	ON_ALLY_HURT_BY_HIT,
	ON_WOUNDED_BY_HIT,

	## Anytime

	ON_HURT,
	ON_DEATH,
	ON_WOUNDED,
	PASSIVE ## Indicates PassiveAbility enum
}

enum PassiveAbility {
	FLYING,
	SCAVENGER
}

enum TargetRule {
	SELF, ## This unit
	OPPONENT_ACROSS, ## Opponent directly opposing this unit
	OPPONENT_ENGAGED, ## Opponent this unit is in combat with
	OPPONENT_HIGHEST_HP, ## Opponent with the highest HP
	OPPONENT_LOWEST_HP, ## Opponent with the lowest HP
	DEAD_ACROSS, ## Dead unit (either ally or opponent) or the lowest health opponent accross 
	ALL_OPPONENTS_ACROSS, ## All opposing units directly across from this unit 
	ALL_OPPONENTS, ## All opposing units
	ALL_ALLIES, ## All allied units
	ALL, ## All units
}

enum UnitStat {
	BASE_HP,
	BASE_ATK,
	BASE_ARM,
	BASE_SPD,
	BASE_MP,
	HP,
	ATK,
	ARM,
	SPD,
	MP,
	ITM,

	IS_DEAD,
	IS_BACKLINE,
	BLOCKS_BACKLINE,

	ALIVE_DEFENSE,
	ARMORED_DEFENSE,
	FULL_HEALTH_DEFENSE,
	
	IS_FLYING,
}

enum AbilityConditionOperation {
	EQUALS,
	GREATER,
	LESSER,
}

enum AbiltiyConditionType {
	BOOLEAN,
	SCALAR,
	UNITS,
}

## Nunber of rows in the battlefield
const BF_ROWS = 4
## Number of columns in the battlefield
const BF_COLS = 3
const BF_ENEMY_BACKLINE_ROW = 0
const BF_ENEMY_FRONTLINE_ROW = 1
const BF_PLAYER_FRONTLINE_ROW = 2
const BF_PLAYER_BACKLINE_ROW = 3