extends Control

const MAIN_MENU = "res://scenes/main menu/main_menu.tscn"
const BUGEISHA_STATS := preload("res://characters/players/bugeisha/bugeisha_stats.tres")
const GUNNER_STATS := preload("res://characters/players/gunner/gunner_stats.tres")
const ASSASSIN_STATS := preload("res://characters/players/assassin/assassin_stats.tres")

@onready var character_name = $CharacterName
@onready var description = $Description
@onready var character_preview = $CharacterPreview

var current_character: PlayerStats: set = set_current_character

func _ready() -> void:
	set_current_character(BUGEISHA_STATS)

func set_current_character(new_character: PlayerStats) -> void:
	current_character = new_character
	character_name.text = current_character.character_name
	description.text = current_character.description
	character_preview.texture = current_character.sprite

func _on_bugeisha_btn_pressed():
	set_current_character(BUGEISHA_STATS)

func _on_gunner_btn_pressed():
	set_current_character(GUNNER_STATS)

func _on_assassin_btn_pressed():
	set_current_character(ASSASSIN_STATS)

func _on_continue_btn_pressed():
	pass # Replace with function body.

func _on_back_btn_pressed():
	get_tree().change_scene_to_file(MAIN_MENU)
