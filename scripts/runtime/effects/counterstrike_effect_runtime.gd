extends EffectRuntime
class_name CounterstrikeEffectRuntime

func init(res: CounterstrikeEffectResource) -> void:
	name_id = "Counterstrike Effect"

# Source is always the ability holder, so if from_enemy is enabled, the target must be the engaged opponent
func apply(source: UnitRuntime, target: UnitRuntime, data: BattleStateData = null) -> void:
	if source.is_dead:
		Console.print_line("* [%s] is dead" % source)
		return

	if target.is_dead:
		Console.print_line("* [%s] is dead" % target)
		return
	
	data.defenders_queue.push_front(target)
	data.counterstrike_queue.push_front(source)

	Console.print_line("* [%s] prepared a counter strike against [%s]" % [source, target])
