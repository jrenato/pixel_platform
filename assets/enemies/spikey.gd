extends CharacterBody2D

var direction : Vector2 = Vector2.LEFT

@onready var edge_check_left : RayCast2D = $EdgeCheckLeft
@onready var edge_check_right : RayCast2D = $EdgeCheckRight
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	velocity = Vector2.ZERO
	up_direction = Vector2.UP

func _physics_process(_delta: float) -> void:
	var found_wall : bool = is_on_wall()
	var found_edge : bool = not edge_check_left.is_colliding() or not edge_check_right.is_colliding()

	if found_wall or found_edge:
		direction *= -1

	sprite.flip_h = direction.x > 0

	velocity = direction * 25
	move_and_slide()
