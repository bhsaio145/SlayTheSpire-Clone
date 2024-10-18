extends HBoxContainer

func _ready():
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparentRequest.connect(_on_card_ui_reparentRequested)

func _on_card_ui_reparentRequested(child: CardUI) -> void:
	child.reparent(self)
