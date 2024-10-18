class_name CardUI
extends Control

signal reparentRequest(whichCardUI: CardUI)

@export var card: Card

@onready var drop_detector = $DropDetector
@onready var cardStateMachineNode: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []

var parent: Control
var tween: Tween

func _ready():
	cardStateMachineNode.init(self)

func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

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
