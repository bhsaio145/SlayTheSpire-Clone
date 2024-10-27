extends Node2D

@export var player_stats: PlayerStats

@onready var battleUI: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler as EnemyHandler
@onready var player: Player = $Player as Player

func _ready() -> void:
	var new_stats: PlayerStats = player_stats.create_instance()
	battleUI.player_stats = new_stats
	player.stats = new_stats
	
	enemy_handler.child_order_changed.connect(_on_enemy_child_order_changed)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	
	start_battle(new_stats)

func start_battle(stats: PlayerStats) -> void:
	enemy_handler.reset_enemy_action()
	player_handler.start_battle(stats)

func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_action()

func _on_enemy_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("-Victory Message-")

func _on_player_died() -> void:
	print("-Game Over Message-")
