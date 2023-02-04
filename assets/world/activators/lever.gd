extends Activator

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body is Player:
		body.nearest_activator = self
		super(body)


func _on_body_exited(body: Node2D) -> void:
	super(body)
	if body is Player:
		body.nearest_activator = null
		super(body)


func trigger() -> void:
	super()


func activate() -> void:
	super()
	animated_sprite.play("trigger")
	SoundPlayer.play_sound(SoundPlayer.HANDLE)


func deactivate() -> void:
	super()
	animated_sprite.play_backwards("trigger")
	SoundPlayer.play_sound(SoundPlayer.HANDLE)
