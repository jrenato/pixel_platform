extends CanvasLayer

@onready var main_menu = $Main
@onready var settings_menu = $Settings


func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://assets/world/levels/level01.tscn")


func _on_button_settings_pressed():
	main_menu.visible = false
	settings_menu.visible = true


func _on_button_about_pressed():
	pass # Replace with function body.


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_settings_back_pressed():
	main_menu.visible = true
	settings_menu.visible = false
