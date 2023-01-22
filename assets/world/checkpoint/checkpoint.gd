extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body) -> void:
	if body is Player and animated_sprite.animation != "checked":
		print("checked")
		animated_sprite.play("checked")
		Events.emit_signal("update_checkpoint", position)
