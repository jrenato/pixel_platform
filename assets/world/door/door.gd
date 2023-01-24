extends Area2D

@export_file("*.tscn") var target_level_path = ""


func _on_body_entered(body: Node2D) -> void:
	if not body is Player or target_level_path.is_empty():
		return

	Transitions.play_exit_level()
	await Transitions.animation_player.animation_finished

	get_tree().paused = true
	Transitions.play_enter_level()
	get_tree().paused = false

	get_tree().change_scene_to_file(target_level_path)
