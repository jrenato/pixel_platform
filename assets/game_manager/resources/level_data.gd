class_name LevelData
extends Resource

var levels : Dictionary = {}


func set_collectible_state(level_name : String, item_name : String, collected : bool) -> void:
	# True: collected
	# False: not collected
	if not level_name.is_empty():
		if not levels.has(level_name):
			levels[level_name] = {}
		if not levels[level_name].has("items"):
			levels[level_name]["items"] = {}

		levels[level_name]["items"][item_name] = collected


func get_collectible_state(level_name : String, item_name : String) -> bool:
	# True: collected
	# False: not collected
	if not level_name.is_empty():
		if not levels.has(level_name):
			return false
		elif not levels[level_name].has("items"):
			return false
		elif not levels[level_name]["items"].has(item_name):
			return false
		else:
			return levels[level_name]["items"][item_name]

	return false
