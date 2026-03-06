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
    SELF,
    ENEMY,
    ALL_ENEMIES,
    ALL_ALLIES,
    ALL,
}