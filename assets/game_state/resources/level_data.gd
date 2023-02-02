class_name LevelData
extends Resource

var levels : Dictionary = {}


func set_collectible_state(level_name : String, item_name : String, collected : bool) -> void:
	# True: collected
	# False: not collected
	if not level_name.is_empty():
		levels[level_name]["items"][item_name] = collected


func get_collectible_state(level_name : String, item_name : String) -> bool:
	# True: collected
	# False: not collected
	if not level_name.is_empty():
		if levels[level_name]["items"].has(item_name):
			return levels[level_name]["items"][item_name]
	# If level or collectible not found, return false
	# Otherwise, object will be destroyed as soon as level_data is created
	return false
