class_name CardUI
extends Control

signal reparentRequest(whichCardUI: CardUI)

@onready var drop_detector = $DropDetector
@onready var cardStateMachineNode: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []

func _ready():
	cardStateMachineNode.init(self)

func _input(event: InputEvent) -> void:
	cardStateMachineNode.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	cardStateMachineNode.on_gui_input(event)

func _on_mouse_entered() -> void:
	cardStateMachineNode.on_mouse_entered()

func _on_mouse_exited() -> void:
	cardStateMachineNode.on_mouse_exited()

func _on_drop_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
