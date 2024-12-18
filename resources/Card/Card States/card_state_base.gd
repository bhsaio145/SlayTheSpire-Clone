extends CardStates

func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparentRequest.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO
	card_ui.position = card_ui.original_position
	card_ui.rotation_degrees = card_ui.original_rotation

func on_gui_input(event: InputEvent) -> void:
	if not card_ui.playable or card_ui.disabled:
		return
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transitionRequested.emit(self, CardStates.State.CLICKED)

func on_mouse_entered() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	
	card_ui.position.y = -70
	card_ui.rotation_degrees = 0
	
func on_mouse_exited() -> void:
	if not card_ui.playable or card_ui.disabled:
		return
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	
	card_ui.position = card_ui.original_position
	card_ui.rotation_degrees = card_ui.original_rotation
