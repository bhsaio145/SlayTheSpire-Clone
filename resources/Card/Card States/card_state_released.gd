extends CardStates

var played: bool

func enter() -> void:
	played = false
	
	if not card_ui.targets.is_empty():
		played = true

func on_input(event: InputEvent) -> void:
	if played:
		return
	transitionRequested.emit(self, CardStates.State.BASE)
