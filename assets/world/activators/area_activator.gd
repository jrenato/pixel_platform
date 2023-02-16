extends Activator


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		activate()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		deactivate()
