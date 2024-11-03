extends EnemyAction

@export var block := 12
@export var hp_threshold := 0.5

var already_used := false

func is_performable() -> bool:
	if not enemy or already_used:
		return false
	
	var hp_low := enemy.stats.health <= (enemy.stats.max_health * hp_threshold)
	already_used = hp_low
	
	return hp_low

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.sound = sound
	block_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_taken.emit(enemy)
	)
