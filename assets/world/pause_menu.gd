extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_paused : bool = false :
	set(value):
		is_paused = value
		update_paused_state()
	get:
		return is_paused


func _ready() -> void:
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = !is_paused


func update_paused_state():
	if is_paused:
		animation_player.play("Pause")
	else:
		animation_player.play("Unpause")

	get_tree().paused = is_paused
	visible = is_paused


func _on_button_resume_pressed() -> void:
	is_paused = false


func _on_button_main_menu_pressed() -> void:
	is_paused = false
	SceneTransition.change_scene(GameData.main_menu)


func _on_button_quit_pressed() -> void:
	get_tree().quit()
