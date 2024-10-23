class_name BattleUI
extends CanvasLayer

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var hand: Hand = $Hand as Hand
@onready var actionPointUI: ActionPointUI = $ActionPointUI as ActionPointUI
@onready var end_turn_button: Button = $EndTurnButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)

func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value
	actionPointUI.player_stats = player_stats
	hand.player_stats = player_stats

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false

func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
