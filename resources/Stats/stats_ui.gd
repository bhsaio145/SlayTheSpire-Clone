class_name StatsUI
extends Control

@onready var block: Control = $Block
@onready var block_label: Label = $Block/BlockLabel
@onready var health: Control = $Health
@onready var health_bar: ProgressBar = $Health/HealthBar
@onready var health_label: Label = $Health/HealthLabel

func setup_stats(stats: Stats) -> void:
	health_bar.max_value = stats.max_health
	health_bar.value = stats.max_health

func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health_label.text = str(stats.health, "/" , stats.max_health)
	health_bar.value = stats.health
	
	block.visible = stats.block > 0
	health.visible = stats.health > 0
