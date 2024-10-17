extends CardStates

func enter() -> void:
	card_ui.drop_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transitionRequested.emit(self, CardStates.State.DRAGGING)
