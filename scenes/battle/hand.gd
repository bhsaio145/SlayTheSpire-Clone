class_name Hand
extends Control

@export_group("Gameplay")
@export var player_stats: PlayerStats

@export_group("Card Fanning")
@export var hand_curve: Curve
@export var rotation_curve: Curve
@export var rotation_degree := 5
@export var seperation := -10
@export var height_offset := -15

@onready var card_ui := preload("res://resources/Card/card_ui.tscn")

func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparentRequest.connect(_on_card_ui_reparentRequested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.player_stats = player_stats
	update_hand_curve()

func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

func _on_card_ui_reparentRequested(child: CardUI) -> void:
	child.reparent(self)
	var new_index := clampi(child.original_index, 0 , get_child_count())
	move_child.call_deferred(child, new_index)

func update_hand_curve() -> void:
	var card_size := Vector2(125,175)
	var card_count := get_child_count()
	var total_card_size := (card_size.x * card_count) + (seperation * (card_count-1))
	var final_seperation := seperation
	
	if total_card_size > size.x:
		final_seperation = (size.x - card_size.x * card_count) / (card_count-1)
		total_card_size = size.x
	
	var offset := (size.x - total_card_size) / 2
	
	for i in card_count:
		var card := get_child(i)
		var height_multiplier := hand_curve.sample(1.0 / (card_count-1) * i)
		var rotation_multiplier := rotation_curve.sample(1.0 / (card_count-1) * i)
		
		if card_count == 1:
			height_multiplier = 0.0
			rotation_multiplier = 0.0
		
		var final_x: float = offset + card_size.x * i + final_seperation * i
		var final_y: float = height_offset * height_multiplier
		
		card.set_position_and_rotation( Vector2(final_x, final_y), rotation_degree * rotation_multiplier)
