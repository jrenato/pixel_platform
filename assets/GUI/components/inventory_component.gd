extends PanelContainer

@onready var selected_item_texture: TextureRect = $MarginContainer/HBoxContainer/SelectedItemTextureRect
@onready var v_separator: VSeparator = $MarginContainer/HBoxContainer/VSeparator
@onready var stored_item_texture: TextureRect = $MarginContainer/HBoxContainer/StoredItemTextureRect


func _ready() -> void:
	Events.connect("update_inventory_ui", _on_update_inventory_ui)
	_on_update_inventory_ui()


func _on_update_inventory_ui() -> void:
	var selected_item : Item = GameManager.inventory_manager.get_selected_item()
	var stored_item : Item = GameManager.inventory_manager.get_stored_item()

	if selected_item == null and stored_item == null:
		visible = false
		return

	visible = true

	if stored_item == null:
		stored_item_texture.texture = null
		v_separator.visible = false
		stored_item_texture.visible = false
	else:
		stored_item_texture.texture = stored_item.texture
		v_separator.visible = true
		stored_item_texture.visible = true

	if selected_item == null:
		selected_item_texture.texture = null
		selected_item_texture.visible = false
	else:
		selected_item_texture.texture = selected_item.texture
		selected_item_texture.visible = true
