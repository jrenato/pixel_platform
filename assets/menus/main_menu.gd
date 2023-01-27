extends CanvasLayer

@onready var main_menu = $Main
@onready var settings_menu = $Settings
@onready var check_box_fullscreen: CheckBox = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerFullscreen/CheckBoxFullscreen
@onready var h_slider_music: HSlider = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerMusic/HSliderMusic
@onready var h_slider_sound: HSlider = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerSound/HSliderSound


func _ready() -> void:
	SoundPlayer.play_song(SoundPlayer.INTRO)
	main_menu.visible = true
	settings_menu.visible = false

	_create_or_load_save()


func _create_or_load_save() -> void:
	if GameManager.save_exists():
		GameManager.load_savegame()
	else:
		# Change default values to GameManager here, if required
		GameManager.write_savegame()

	# Updates #UI after loading settings
	check_box_fullscreen.button_pressed = GameManager.settings.fullscreen
	h_slider_music.value = GameManager.settings.music_volume
	h_slider_sound.value = GameManager.settings.sound_volume


func _save_game() -> void:
	GameManager.write_savegame()


func _on_button_play_pressed():
	main_menu.visible = false
	settings_menu.visible = false
	SceneTransition.change_scene("res://assets/world/levels/level01.tscn")
	#get_tree().change_scene_to_file("res://assets/world/levels/level01.tscn")


func _on_button_continue_pressed() -> void:
	pass # Replace with function body.


func _on_button_settings_pressed() -> void:
	main_menu.visible = false
	settings_menu.visible = true


func _on_button_about_pressed() -> void:
	#TODO: Add credits scene transition
	pass


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_settings_back_pressed() -> void:
	_save_game()
	main_menu.visible = true
	settings_menu.visible = false


func _on_check_box_fullscreen_toggled(button_pressed: bool) -> void:
	GameManager.settings.fullscreen = button_pressed
	GameManager.write_savegame()


func _on_h_slider_music_value_changed(value):
	GameManager.settings.music_volume = value


func _on_h_slider_sound_value_changed(value):
	SoundPlayer.play_sound(SoundPlayer.BLIP)
	GameManager.settings.sound_volume = value
