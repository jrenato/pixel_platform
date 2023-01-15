extends CharacterBody2D

@export var walk_speed : int = 120.0
@export var friction : int = 60.0
@export var jump_velocity : int = 250.0
@export var minimum_jump : int = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta : float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			velocity.y = -jump_velocity
	else:
		if Input.is_action_just_released("ui_select") and velocity.y < -minimum_jump:
			velocity.y = -minimum_jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("ui_left", "ui_right")

	if direction:
		# Player is moving
		velocity.x = direction * walk_speed
	else:
		# Player is stopping
		velocity.x = move_toward(velocity.x, 0, friction)

	move_and_slide()
