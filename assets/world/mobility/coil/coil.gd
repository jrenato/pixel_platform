extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.frame = 0


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite_2d.frame = 1
		body.is_on_coil = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		animated_sprite_2d.frame = 0
		body.is_on_coil = false
		SoundPlayer.play_sound(SoundPlayer.COIL)
