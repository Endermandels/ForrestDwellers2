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
