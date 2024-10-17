extends CardStates

const DRAG_MIN_THRESHOLD := 0.05

var min_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	min_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MIN_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): min_drag_time_elapsed = true)

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_pressed("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	if cancel:
		transitionRequested.emit(self, CardStates.State.BASE)
	elif confirm and min_drag_time_elapsed:
		get_viewport().set_input_as_handled()
		transitionRequested.emit(self, CardStates.State.RELEASED)
