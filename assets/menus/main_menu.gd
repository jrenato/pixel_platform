extends CanvasLayer

@onready var main_menu = $Main
@onready var settings_menu = $Settings

@onready var button_continue: Button = $Main/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonContinue

@onready var check_box_fullscreen: CheckBox = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerFullscreen/CheckBoxFullscreen
@onready var h_slider_music: HSlider = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerMusic/HSliderMusic
@onready var h_slider_sound: HSlider = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerSound/HSliderSound


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundPlayer.play_song(SoundPlayer.INTRO)
	main_menu.visible = true
	settings_menu.visible = false

	_create_or_load_save()


func _create_or_load_save() -> void:
	if GameManager.save_exists():
		GameManager.load_data()
	else:
		# Change default values to GameManager here, if required
		GameManager.write_data()

	# Updates #UI after loading settings
	## Button continue
	button_continue.disabled = GameManager.game_data.current_level.is_empty()
	## Settings UI
	check_box_fullscreen.button_pressed = GameManager.settings.fullscreen
	h_slider_music.value = GameManager.settings.music_volume
	h_slider_sound.value = GameManager.settings.sound_volume


func _save_game() -> void:
	GameManager.write_data()


func _on_button_play_pressed():
	# Starts a new game, so it must set current level to level1
	# game_data.current_level will be saved on level._ready()
	GameManager.game_data.current_level = GameData.level1
	SceneTransition.change_scene(GameData.level1)


func _on_button_continue_pressed() -> void:
	GameManager.game_data.update_player_position = true
	SceneTransition.change_scene(GameManager.game_data.current_level)


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


func _on_h_slider_music_value_changed(value):
	GameManager.settings.music_volume = value


func _on_h_slider_sound_value_changed(value):
	# Blip, so player can check the sound volume
	SoundPlayer.play_sound(SoundPlayer.BLIP)
	GameManager.settings.sound_volume = value
