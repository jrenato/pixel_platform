extends CanvasLayer

@onready var main_menu = $Main
@onready var settings_menu = $Settings

var music_bus_id : int
var sound_bus_id : int


func _ready() -> void:
	main_menu.visible = true
	settings_menu.visible = false
	music_bus_id = AudioServer.get_bus_index("Music")
	sound_bus_id = AudioServer.get_bus_index("Sound")


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
