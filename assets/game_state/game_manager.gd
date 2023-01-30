extends Node

const SAVE_GAME_PATH : String = "user://gamedata.json"
var version : int = 1

var settings : GameSettings = GameSettings.new()
var game_data : GameData = GameData.new()
var levels : Dictionary = {}


func _ready() -> void:
	settings.init()


func get_current_level() -> String:
	return game_data.current_level


func get_level_data(level_name : String) -> Dictionary:
	if not levels.has(level_name):
		levels[level_name] = {
			"collectibles": {}
		}
	return levels[level_name]


func set_collectible_state(item_name : String, collected : bool) -> void:
	# True: collected
	# False: not collected
	if not get_current_level().is_empty():
		get_level_data(get_current_level())["collectibles"][item_name] = collected


func get_collectible_state(item_name : String) -> bool:
	# True: collected
	# False: not collected
	if not get_current_level().is_empty():
		var level_data : Dictionary = get_level_data(get_current_level())
		if level_data["collectibles"].has(item_name):
			return level_data["collectibles"][item_name]
	# If level or collectible not found, return false
	# Otherwise, object will be destroyed as soon as level_data is created
	return false


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func write_data() -> void:
	var _file : FileAccess = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, FileAccess.get_open_error()])
		return

	var data := {
		"settings": {
			"fullscreen": settings.fullscreen,
			"music_volume": settings.music_volume,
			"sound_volume": settings.sound_volume,
		},
		"game_data":
		{
			"current_level": game_data.current_level,
			"player_x": game_data.player_position.x,
			"player_y": game_data.player_position.y,

			"player_health": game_data.player_health,
			"player_max_health": game_data.player_max_health,

			"player_coins": game_data.player_coins,
			"player_diamonds": game_data.player_diamonds,
		},
		"levels": levels,
	}
	
	var json_string := JSON.stringify(data, "\t")
	_file.store_string(json_string)


func load_data() -> void:
	var _file : FileAccess = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, FileAccess.get_open_error()])
		return

	var content := _file.get_as_text()

	var json = JSON.new()
	var parse_result = json.parse(content)
	if parse_result != OK:
		printerr("Error loading options")
		return

	var data : Dictionary = json.get_data()

	game_data.current_level = data.game_data.current_level
	game_data.player_position = Vector2(data.game_data.player_x, data.game_data.player_y)

	game_data.player_health = data.game_data.player_health
	game_data.player_max_health = data.game_data.player_max_health

	game_data.player_coins = data.game_data.player_coins
	game_data.player_diamonds = data.game_data.player_diamonds

	levels = data.levels

	settings.fullscreen = data.settings.fullscreen
	settings.music_volume = data.settings.music_volume
	settings.sound_volume = data.settings.sound_volume
