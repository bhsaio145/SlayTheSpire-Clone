extends Node

# Card-related events
signal card_drag_started(cardui: CardUI)
signal card_drag_ended(cardui: CardUI)
signal card_aim_started(cardui: CardUI)
signal card_aim_ended(cardui: CardUI)
signal card_played(card: Card)

# Player-related events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended

# Enemy-related events
signal enemy_action_taken(enemy: Enemy)
signal enemy_turn_ended
