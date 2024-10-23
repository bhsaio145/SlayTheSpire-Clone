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
	stats.take_damage(damage)
	if stats.health <= 0:
		queue_free()
