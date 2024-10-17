class_name CardStateMachine
extends Node

@export var initial_state: CardStates

var current_state: CardStates
var states := {}

func init(card: CardUI) -> void:
	for child in get_children():
		if child is CardStates:
			states[child.state] = child
			child.transitionRequested.connect(on_transitionRequested)
			child.card_ui = card
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()

func on_transitionRequested(from: CardStates, to: CardStates.State) -> void:
	if from != current_state:
		return
	var new_state: CardStates = states[to]
	if not new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
