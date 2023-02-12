extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_pushing: Player = null

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if player_pushing:
		velocity.x = player_pushing.velocity.x
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	move_and_slide()
