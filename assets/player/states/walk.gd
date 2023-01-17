extends MoveState


func enter() -> void:
	super.enter()
	current_move_speed = player.walk_speed


func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based on its logic
	var new_state = super.input(event)
	if new_state:
		return new_state
	
	if Input.is_action_just_pressed("run"):
		return run_state

	return null
