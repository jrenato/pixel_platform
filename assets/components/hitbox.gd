extends Area2D

@export var damage : float = 0.5


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage)
