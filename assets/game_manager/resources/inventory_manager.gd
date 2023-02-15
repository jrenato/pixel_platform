extends Resource
class_name InventoryManager

var item_library : Array[Item] = []
var item_library_path : String = "res://assets/game_manager/inventory/items/"

var inventory : Array[Item] = [null, null]


func init() -> void:
	load_library(item_library_path)


func load_library(path : String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				item_library.append(load(path + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		printerr("An error occurred when trying to load the item library")


func get_item_from_library(item_id : String) -> Item:
	for item in item_library:
		if item.id == item_id:
			return item

	return null


func swap_items() -> void:
	if inventory[1] == null:
		return
	var temp_item : Item = inventory[0]
	inventory[0] = inventory[1]
	inventory[1] = temp_item


func has_empty_slot() -> bool:
	for slot in inventory:
		if slot == null:
			return true

	return false


func add_item(item : Item) -> bool:
	for index in inventory.size():
		if inventory[index] == null:
			inventory[index] = item
			if index > 0:
				swap_items()
			return true

	return false


func add_item_with_id(item_id : String) -> bool:
	var item : Item = get_item_from_library(item_id)

	if item:
		return add_item(item)

	return false


func remove_item(index : int) -> void:
	inventory[index] = null


func get_item(index : int) -> Item:
	return inventory[index]


func get_selected_item() -> Item:
	return get_item(0)


func get_stored_item() -> Item:
	return get_item(1)
