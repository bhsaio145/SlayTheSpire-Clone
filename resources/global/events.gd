extends Node

# Card-related events
signal card_drag_started(cardui: CardUI)
signal card_drag_ended(cardui: CardUI)
signal card_aim_started(cardui: CardUI)
signal card_aim_ended(cardui: CardUI)
signal card_played(card: Card)
