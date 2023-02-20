extends Control

@onready var check_box_fullscreen: CheckBox = $CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerFullscreen/CheckBoxFullscreen
@onready var h_slider_music: HSlider = $CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerMusic/HSliderMusic
@onready var h_slider_sound: HSlider = $CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/HBoxContainerSound/HSliderSound

var parent_menu : Control


func update_ui() -> void:
	## Settings UI
	check_box_fullscreen.button_pressed = GameManager.settings.fullscreen
	h_slider_music.value = GameManager.settings.music_volume
	h_slider_sound.value = GameManager.settings.sound_volume


func close_settings_menu() -> void:
	parent_menu.visible = true
	visible = false


func _on_button_settings_back_pressed() -> void:
	GameManager.save_data()
	close_settings_menu()


func _on_check_box_fullscreen_toggled(button_pressed: bool) -> void:
	GameManager.settings.fullscreen = button_pressed


func _on_h_slider_music_value_changed(value):
	GameManager.settings.music_volume = value


func _on_h_slider_sound_value_changed(value):
	# Blip, so player can check the sound volume
	if visible == true:
		SoundPlayer.play_sound(SoundPlayer.BLIP)
	GameManager.settings.sound_volume = value
