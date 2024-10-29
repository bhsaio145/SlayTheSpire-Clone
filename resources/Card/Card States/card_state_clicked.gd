extends CardStates

func enter() -> void:
	card_ui.drop_detector.monitoring = true
	card_ui.original_index = card_ui.get_index()

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transitionRequested.emit(self, CardStates.State.DRAGGING)
