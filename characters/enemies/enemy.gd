class_name Enemy
extends Area2D

const TARGET_OFFSET := 20

@export var stats: Stats: set = set_enemy_stats

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var targeted: ColorRect = $Targeted
@onready var stats_ui: StatsUI = $StatsUI as StatsUI

func set_enemy_stats(value: Stats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_enemy()

func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	sprite2d.texture = stats.sprite
	targeted.position.y = -(sprite2d.get_rect().size.y / 2 + TARGET_OFFSET)
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

func _on_area_entered(_area: Area2D) -> void:
	targeted.show()

func _on_area_exited(_area: Area2D) -> void:
	targeted.hide()
