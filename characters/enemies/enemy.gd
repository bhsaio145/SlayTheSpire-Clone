class_name Enemy
extends Area2D

const TARGET_OFFSET := 20

@export var stats: EnemyStats: set = set_enemy_stats

@onready var sprite2d: Sprite2D = $Sprite2D
@onready var targeted: ColorRect = $Targeted
@onready var stats_ui: StatsUI = $StatsUI as StatsUI
@onready var intent_ui: IntentUI = $IntentUI as IntentUI

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction: set = set_current_action

func set_current_action(value: EnemyAction) -> void:
	current_action = value
	if current_action:
		intent_ui.update_intent(current_action.intent)

func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)
	
	update_enemy()

func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
	
	var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self

func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	sprite2d.texture = stats.sprite
	targeted.position.y = -(sprite2d.get_rect().size.y / 2 + TARGET_OFFSET)
	stats_ui.setup_stats(stats)
	setup_ai()
	update_stats()

func do_turn() -> void:
	stats.block = 0
	
	if not current_action:
		return
	
	current_action.perform_action()

func update_action() -> void:
	if not enemy_action_picker:
		return
	
	if not current_action:
		current_action = enemy_action_picker.get_action()
		return
	
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action

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
