class_name CardUI
extends Control

signal reparentRequest(whichCardUI: CardUI)

const BASE_STYLEBOX := preload("res://resources/Card/Card States/card_base_stylebox.tres")
const HOVER_STYLEBOX := preload("res://resources/Card/Card States/card_hover_stylebox.tres")

@export var card: Card : set = _set_card
@export var player_stats: PlayerStats : set = _set_player_stats

@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon
@onready var description = $"Description Margin/Description"
@onready var drop_detector = $DropDetector
@onready var cardStateMachineNode: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var original_index := self.get_index()


var parent: Control
var tween: Tween
var playable := true : set = _set_playable
var disabled := false

func _ready():
	Events.card_aim_started.connect(_on_card_aim_or_drag_started)
	Events.card_aim_ended.connect(_on_card_aim_or_drag_ended)
	Events.card_drag_started.connect(_on_card_aim_or_drag_started)
	Events.card_drag_ended.connect(_on_card_aim_or_drag_ended)
	cardStateMachineNode.init(self)

func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	cost.text = str(card.cost)
	icon.texture = card.icon
	description.text = card.description

func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED)
		icon.modulate = Color(1,1,1,0.5)
		description.modulate = Color(1,1,1,0.5)
	else:
		cost.remove_theme_color_override("font_color")
		icon.modulate = Color(1,1,1,1)
		description.modulate = Color(1,1,1,1)

func _set_player_stats(value: PlayerStats) -> void:
	player_stats = value
	player_stats.stats_changed.connect(_on_char_stats_changed)

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

func play() -> void:
	if not card:
		return
	
	card.play(targets, player_stats)
	queue_free()

func _on_card_aim_or_drag_started(used_card: CardUI) -> void:
	if used_card == self:
		return
	disabled = true

func _on_card_aim_or_drag_ended(_card: CardUI) -> void:
	disabled = false
	self.playable = player_stats.can_play_card(card)

func _on_char_stats_changed() -> void:
	self.playable = player_stats.can_play_card(card)
