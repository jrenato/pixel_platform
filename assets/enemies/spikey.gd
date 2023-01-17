extends CharacterBody2D

var direction : Vector2 = Vector2.LEFT

@onready var edge_check : RayCast2D = $EdgeCheck

func _ready() -> void:
	velocity = Vector2.ZERO
	up_direction = Vector2.UP

func _physics_process(delta: float) -> void:
	var found_wall : bool = is_on_wall()
	var found_edge : bool = not edge_check.is_colliding()

	if found_wall or found_edge:
		direction *= -1

	velocity = direction * 25
	move_and_slide()
