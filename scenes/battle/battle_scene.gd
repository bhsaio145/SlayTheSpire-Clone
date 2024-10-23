extends Node2D

@export var player_stats: PlayerStats

@onready var battleUI: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player as Player

func _ready() -> void:
	var new_stats: PlayerStats = player_stats.create_instance()
	battleUI.player_stats = new_stats
	player.stats = new_stats
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(player_handler.start_turn)
	
	start_battle(new_stats)

func start_battle(stats: PlayerStats) -> void:
	player_handler.start_battle(stats)
