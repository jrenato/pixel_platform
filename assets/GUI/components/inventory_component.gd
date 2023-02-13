extends PanelContainer

@onready var key_texture_rect: TextureRect = $MarginContainer/HBoxContainer/KeyTextureRect


func _ready() -> void:
	Events.connect("update_inventory_ui", _on_update_inventory_ui)
	_on_update_inventory_ui()


func _on_update_inventory_ui() -> void:
	#diamonds_label.text = "%02d" % GameManager.game_data.player_diamonds
	pass
