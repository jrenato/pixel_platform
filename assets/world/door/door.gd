extends Area2D

@export_file("*.tscn") var target_level_path = ""


func _on_body_entered(body: Node2D) -> void:
	if not body is Player or target_level_path.is_empty():
		return

	SceneTransition.change_scene(target_level_path)

