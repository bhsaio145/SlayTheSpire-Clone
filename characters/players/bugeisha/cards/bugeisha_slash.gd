extends Card

func apply_effect(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.amount = 6
	damage_effect.execute(targets)
