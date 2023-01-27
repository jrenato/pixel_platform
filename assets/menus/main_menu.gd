extends CanvasLayer

var _save : GameManager = GameManager.new()

@onready var main_menu = $Main
@onready var settings_menu = $Settings

var music_bus_id : int
var sound_bus_id : int


func _ready() -> void:
	main_menu.visible = true
	settings_menu.visible = false
	music_bus_id = AudioServer.get_bus_index("Music")
	sound_bus_id = AudioServer.get_bus_index("Sound")

	_create_or_load_save()


func _create_or_load_save() -> void:
	if _save.save_exists():
		_save.load_savegame()
	else:
		#_save.inventory.add_item("healing_gem", 3)
		#_save.inventory.add_item("sword", 1)

		#_save.map_name = "map_1"
		#_save.global_position = _player.global_position

		_save.write_savegame()

	# After creating or loading a save resource, we need to dispatch its data
	# to the various nodes that need it.
	#_player.global_position = _save.global_position
	#_ui_inventory.inventory = _save.inventory
	#_player.stats = _save.character
	#_ui_info_display.character = _save.character


func _save_game() -> void:
	#_save.global_position = _player.global_position
	_save.write_savegame()


func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://assets/world/levels/level01.tscn")


func _on_button_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true


func _on_button_about_pressed() -> void:
	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_settings_back_pressed() -> void:
	main_menu.visible = true
	settings_menu.visible = false


func _on_check_box_fullscreen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_h_slider_music_value_changed(value):
	AudioServer.set_bus_mute(music_bus_id, value == -35)
	AudioServer.set_bus_volume_db(music_bus_id, value)


func _on_h_slider_sound_value_changed(value):
	AudioServer.set_bus_mute(sound_bus_id, value == -35)
	AudioServer.set_bus_volume_db(sound_bus_id, value)
