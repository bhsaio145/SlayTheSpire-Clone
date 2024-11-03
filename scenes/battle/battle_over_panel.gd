class_name BattleOverPanel
extends Panel

@onready var label: Label = $Label
@onready var button: Button = $Button

func _ready() -> void:
	button.pressed.connect(get_tree().reload_current_scene)
	Events.battle_over_screen_requested.connect(show_screen)
	hide()

func show_screen(text: String) -> void:
	label.text = text
	show()
	get_tree().paused = true
