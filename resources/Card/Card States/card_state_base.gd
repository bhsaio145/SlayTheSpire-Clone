extends CardStates

func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	card_ui.reparentRequest.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transitionRequested.emit(self, CardStates.State.CLICKED)
