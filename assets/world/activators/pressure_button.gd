extends Activator

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var activated : bool = false
@export_enum("Up", "Down", "Left", "Right") var direction : int = 0

func _ready() -> void:
	#TODO: Find out why this is necessary
	animated_sprite.play_backwards("trigger")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		activate()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		deactivate()


func trigger() -> void:
	pass


func activate() -> void:
	activated = true
	animated_sprite.play("trigger")


func deactivate() -> void:
	activated = false
	animated_sprite.play_backwards("trigger")
