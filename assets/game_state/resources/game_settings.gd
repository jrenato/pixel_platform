class_name GameSettings
extends Resource

@export var fullscreen : bool = false :
	set(value):
		fullscreen = value
		update_fullscreen(fullscreen)
	get:
		return fullscreen

@export_range(-35, 0, 1) var music_volume : int = 0 :
	set(value):
		music_volume = value
		update_music_bus(music_volume)
	get:
		return music_volume

@export_range(-35, 0, 1) var sound_volume : int = 0 :
	set(value):
		sound_volume = value
		update_sound_bus(sound_volume)
	get:
		return sound_volume

var music_bus_id : int
var sound_bus_id : int


func _ready() -> void:
	music_bus_id = AudioServer.get_bus_index("Music")
	sound_bus_id = AudioServer.get_bus_index("Sound")


func update_fullscreen(fullscreen : bool) -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func update_music_bus(value : int) -> void:
	AudioServer.set_bus_mute(music_bus_id, value == -35)
	AudioServer.set_bus_volume_db(music_bus_id, value)


func update_sound_bus(value : int) -> void:
	AudioServer.set_bus_mute(sound_bus_id, value == -35)
	AudioServer.set_bus_volume_db(sound_bus_id, value)
