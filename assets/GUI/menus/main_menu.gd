extends Control

@onready var button_continue: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonContinue

var settings_menu : Control


func init() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundPlayer.play_song(SoundPlayer.INTRO)

	# Updates #UI after loading settings
	## Button continue
	if not GameManager.current_level.is_empty():
		button_continue.disabled = false
		button_continue.focus_mode = Control.FOCUS_ALL

	# Updates settings menu
	settings_menu.update_ui()

	open_main_menu()


func open_main_menu() -> void:
	visible = true
	settings_menu.visible = false


func open_settings_menu() -> void:
	visible = false
	settings_menu.visible = true


func _on_button_play_pressed():
	# Starts a new game, so it must set current level to level1
	# current_level will be saved on level._ready()
	GameManager.new_game()
	SceneTransition.change_scene(GameData.level1)


func _on_button_continue_pressed() -> void:
	GameManager.game_data.restore_player_position = true
	SceneTransition.change_scene(GameManager.current_level)


func _on_button_settings_pressed() -> void:
	open_settings_menu()


func _on_button_about_pressed() -> void:
	#TODO: Add credits scene
	pass


func _on_button_quit_pressed() -> void:
	get_tree().quit()
