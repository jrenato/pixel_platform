extends PanelContainer

@onready var coins_label: Label = $MarginContainer/HBoxContainer/CoinsAmountLabel
@onready var diamonds_label: Label = $MarginContainer/HBoxContainer/DiamondsAmountLabel


func _ready() -> void:
	Events.connect("update_coins_ui", _on_update_coins_ui)
	Events.connect("update_diamonds_ui", _on_update_diamonds_ui)
	_on_update_coins_ui()
	_on_update_diamonds_ui()


func _on_update_coins_ui() -> void:
	coins_label.text = "%03d" % GameManager.game_data.player_coins


func _on_update_diamonds_ui() -> void:
	diamonds_label.text = "%02d" % GameManager.game_data.player_diamonds
