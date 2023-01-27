extends Node

const SAVE_GAME_PATH : String = "user://gamedata.json"
var version : int = 1

var settings : GameSettings = GameSettings.new()


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func write_savegame() -> void:
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
#		"global_position":
#		{
#			"x": global_position.x,
#			"y": global_position.y,
#		},
#		"map_name": map_name,
#		"player":
#		{
#			"display_name": character.display_name,
#			"run_speed": character.run_speed,
#			"level": character.level,
#			"experience": character.experience,
#			"strength": character.strength,
#			"endurance": character.endurance,
#			"intelligence": character.intelligence,
#		},
#		"inventory": inventory.items,
	}
	
	var json_string := JSON.stringify(data, "\t")
	_file.store_string(json_string)


func load_savegame() -> void:
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

	settings.fullscreen = data.settings.fullscreen
	settings.music_volume = data.settings.music_volume
	settings.sound_volume = data.settings.sound_volume

#	global_position = Vector2(data.global_position.x, data.global_position.y)
#	map_name = data.map_name

#	character = Character.new()
#	character.display_name = data.player.display_name
#	character.run_speed = data.player.run_speed
#	character.level = data.player.level
#	character.experience = data.player.experience
#	character.strength = data.player.strength
#	character.endurance = data.player.endurance
#	character.intelligence = data.player.intelligence
#
#	inventory = Inventory.new()
#	inventory.items = data.inventory
