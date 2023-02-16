extends PanelContainer

@onready var selected_item_texture: TextureRect = $MarginContainer/HBoxContainer/SelectedItemTextureRect
@onready var v_separator: VSeparator = $MarginContainer/HBoxContainer/VSeparator
@onready var stored_item_texture: TextureRect = $MarginContainer/HBoxContainer/StoredItemTextureRect


func _ready() -> void:
#	selected_item_texture.visible = false
#	stored_item_texture.visible = false

	Events.connect("update_inventory_ui", _on_update_inventory_ui)
	_on_update_inventory_ui()


func _on_update_inventory_ui() -> void:
	var selected_item : Item = GameManager.inventory_manager.get_selected_item()
	var stored_item : Item = GameManager.inventory_manager.get_stored_item()

	if selected_item == null and stored_item == null:
		visible = false
		return

	visible = true
	v_separator.visible = stored_item != null

	_update_item_texture(selected_item, selected_item_texture)
	_update_item_texture(stored_item, stored_item_texture)



func _update_item_texture(item : Item, item_texture : TextureRect) -> void:
	if item == null:
		item_texture.texture = null
		item_texture.visible = false
	else:
		item_texture.texture = item.texture
		item_texture.visible = true
