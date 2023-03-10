extends MoveState

var current_dash_time : float = 0
var dash_direction : float = 0.0


# Upon entering the state, set dash direction to either current input or the direction the player is facing if no input is pressed
func enter() -> void:
	super.enter()

	current_move_speed = player.move_data.dash_speed

	current_dash_time = player.move_data.dash_time

	if player.animated_sprite.flip_h:
		dash_direction = 1.0
	else:
		dash_direction = -1.0


# Override MoveState input() since we don't want to change states based on player input
func input(_event : InputEvent) -> BaseState:
	return null


# Move in the dash_direction every frame
func get_movement_input() -> float:
	return dash_direction


# Track how long we've been dashing so we know when to exit
func process(delta: float) -> BaseState:
	current_dash_time -= delta

	if current_dash_time > 0:
		return null

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	return idle_state
