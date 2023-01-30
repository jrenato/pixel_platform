extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


func activate() -> void:
	animated_sprite.play("checked")


func _on_body_entered(body) -> void:
	if body is Player and animated_sprite.animation != "checked":
		activate()
		Events.emit_signal("update_checkpoint", position)
		GameManager.set_collectible_state(name, true)
