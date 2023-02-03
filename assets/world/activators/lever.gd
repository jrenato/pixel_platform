extends Activator

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var activated : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.nearest_activator = self
		super(body)


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.nearest_activator = null
		super(body)


func trigger() -> void:
	if not activated:
		activate()
	else:
		deactivate()


func activate() -> void:
	activated = true
	animated_sprite.play("trigger")


func deactivate() -> void:
	activated = false
	animated_sprite.play_backwards("trigger")