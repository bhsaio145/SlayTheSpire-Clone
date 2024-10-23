class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var player: PlayerStats

func _ready() -> void:
	Events.card_played.connect(_on_card_played)

func start_battle(player_stats: PlayerStats) -> void:
	player = player_stats
	player.draw_pile = player.deck.duplicate(true)
	player.draw_pile.shuffle()
	player.discard = CardPile.new()
	start_turn()

func start_turn() -> void:
	player.block = 0
	player.reset_action_points()
	draw_cards(player.card_draw)

func end_turn() -> void:
	hand.disable_hand()
	discard_cards()

func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(player.draw_pile.draw_card())
	reshuffle_deck_from_discard()

func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)

func discard_cards() -> void:
	var tween := create_tween()
	for card_ui in hand.get_children():
		tween.tween_callback(player.discard.add_card.bind(card_ui.card))
		tween.tween_callback(hand.discard_card.bind(card_ui))
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	
	tween.finished.connect(
		func(): Events.player_hand_discarded.emit()
	)

func reshuffle_deck_from_discard() -> void:
	if not player.draw_pile.empty():
		return
	
	while not player.discard.empty():
		player.draw_pile.add_card(player.discard.draw_card())
	
	player.draw_pile.shuffle()

func _on_card_played(card: Card) -> void:
	player.discard.add_card(card)
