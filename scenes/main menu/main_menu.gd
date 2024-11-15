extends Control

const CHAR_SELECT_SCREEN = "res://scenes/character selection/character_selection.tscn"

func _ready() -> void:
	get_tree().paused = false

func _on_continue_btn_pressed() -> void:
	pass # Replace with function body.

func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file(CHAR_SELECT_SCREEN)

func _on_credit_btn_pressed() -> void:
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
