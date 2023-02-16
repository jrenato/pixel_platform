extends Node

const SAVE_GAME_PATH : String = "user://gamedata.json"
var version : float = 0.1

var game_data : GameData = GameData.new()
var settings : GameSettings = GameSettings.new()
var level_data : LevelData = LevelData.new()
var inventory_manager : InventoryManager = InventoryManager.new()


var current_level : String = "" :
	set(value):
		game_data.current_level = value
		current_level = value
	get:
		return game_data.current_level


func _ready() -> void:
	settings.init()
	inventory_manager.init()
	_create_or_load_save()


func _create_or_load_save() -> void:
	if save_exists():
		var loaded : bool = load_data()
		if not loaded:
			# Save default settings
			save_data()
	else:
		# Change default values to GameManager here, if required
		save_data()


func new_game() -> void:
	game_data.current_level = GameData.level1
	game_data.player_health = GameManager.game_data.player_max_health
	game_data.player_coins = 0
	game_data.player_diamonds = 0
	level_data.levels = {}


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func save_data() -> void:
	var _file : FileAccess = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, FileAccess.get_open_error()])
		return

	var data := {
		"version": version,
		"settings": settings.to_dict(),
		"game_data": game_data.to_dict(),
		"levels": level_data.levels,
	}

	var json_string := JSON.stringify(data, "\t")
	_file.store_string(json_string)


func load_data() -> bool:
	var _file : FileAccess = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, FileAccess.get_open_error()])
		return false

	var content := _file.get_as_text()

	var json = JSON.new()
	var parse_result = json.parse(content)
	if parse_result != OK:
		printerr("Error loading options")
		return false

	var data : Dictionary = json.get_data()

	if not data.has("version") or data["version"] != version:
		return false

	settings.from_dict(data.settings)
	game_data.from_dict(data.game_data)
	level_data.levels = data.levels
	return true


func set_collectible_state(item_name : String, collected : bool) -> void:
	level_data.set_collectible_state(current_level, item_name, collected)


func get_collectible_state(item_name : String) -> bool:
	# True: collected
	# False: not collected
	return level_data.get_collectible_state(current_level, item_name)
