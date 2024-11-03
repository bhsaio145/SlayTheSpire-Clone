class_name Player
extends Node2D

@export var stats: PlayerStats: set = set_character_stats

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI

func set_character_stats(value: PlayerStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_player()

func update_player() -> void:
	if not stats is PlayerStats:
		return
	if not is_inside_tree():
		await ready
	sprite2d.texture = stats.sprite
	stats_ui.setup_stats(stats)
	update_stats()

func update_stats() -> void:
	stats_ui.update_stats(stats)

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	var tween := create_tween()
	tween.tween_callback(player_shake.bind(20, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.2)
	
	tween.finished.connect(
		func():
			if stats.health <= 0:
				Events.player_died.emit()
				queue_free()
	)

func player_shake(strength: float, duration: float) -> void:
	var orig_pos := position
	var shake_count := 15
	var tween := create_tween()
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target := orig_pos + strength * shake_offset
		if i%2 == 0:
			target = orig_pos
		tween.tween_property(self, "position", target, duration / float(shake_count))
		strength *= 0.75
	tween.finished.connect(func(): position = orig_pos)
