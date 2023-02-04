class_name Activator
extends Area2D

@export var activated : bool = false


func _on_body_entered(body: Node2D) -> void:
	pass


func _on_body_exited(body: Node2D) -> void:
	pass


func trigger() -> void:
	if not activated:
		activate()
	else:
		deactivate()


func activate() -> void:
	activated = true


func deactivate() -> void:
	activated = false
