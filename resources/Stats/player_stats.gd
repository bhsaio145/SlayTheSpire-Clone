class_name PlayerStats
extends Stats

@export var starting_deck: CardPile
@export var card_draw: int
@export var max_action_points: int

var action_points: int: set = set_action_points
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func set_action_points(value: int) -> void:
	action_points = value
	stats_changed.emit()

func reset_action_points() -> void:
	self.action_points = max_action_points

func can_play_card(card: Card) -> bool:
	return action_points >= card.cost

func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_action_points()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
