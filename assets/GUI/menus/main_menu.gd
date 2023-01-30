extends Control

@onready var button_continue: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonContinue

var settings_menu : Control


func init() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundPlayer.play_song(SoundPlayer.INTRO)

	_create_or_load_save()
	open_main_menu()


func _create_or_load_save() -> void:
	if GameManager.save_exists():
		GameManager.load_data()
	else:
		# Change default values to GameManager here, if required
		GameManager.write_data()

	# Updates #UI after loading settings
	## Button continue
	if not GameManager.game_data.current_level.is_empty():
		button_continue.disabled = false
		button_continue.focus_mode = Control.FOCUS_ALL

	settings_menu.update_ui()


func open_main_menu() -> void:
	visible = true
	settings_menu.visible = false


func open_settings_menu() -> void:
	print("Opening settings menu")
	visible = false
	settings_menu.visible = true


func _on_button_play_pressed():
	# Starts a new game, so it must set current level to level1
	# game_data.current_level will be saved on level._ready()
	GameManager.game_data.current_level = GameData.level1
	GameManager.game_data.player_health = GameManager.game_data.player_max_health
	GameManager.game_data.player_coins = 0
	GameManager.game_data.player_diamonds = 0
	SceneTransition.change_scene(GameData.level1)


func _on_button_continue_pressed() -> void:
	GameManager.game_data.update_player_data = true
	SceneTransition.change_scene(GameManager.game_data.current_level)


func _on_button_settings_pressed() -> void:
	open_settings_menu()


func _on_button_about_pressed() -> void:
	#TODO: Add credits scene
	pass


func _on_button_quit_pressed() -> void:
	get_tree().quit()
