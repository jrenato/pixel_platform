class_name GameManager
extends RefCounted

const SAVE_GAME_PATH := "user://gamedata.json"

var version := 1

#var character: Resource = Character.new()
#var inventory: Resource = Inventory.new()

var map_name := ""
var global_position := Vector2.ZERO


func save_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)


func write_savegame() -> void:
	var _file : FileAccess = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, FileAccess.get_open_error()])
		return

	var data := {
		"test": 0,
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

	var data: Dictionary = json.get_data()
	
	print(data.test)

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
