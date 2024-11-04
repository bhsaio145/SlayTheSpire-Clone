class_name Hand
extends HBoxContainer

@export var player_stats: PlayerStats

@onready var card_ui := preload("res://resources/Card/card_ui.tscn")

func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparentRequest.connect(_on_card_ui_reparentRequested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.player_stats = player_stats

func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

func _on_card_ui_reparentRequested(child: CardUI) -> void:
	child.reparent(self)
	var new_index := clampi(child.original_index, 0 , get_child_count())
	move_child.call_deferred(child, new_index)