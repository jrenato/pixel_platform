extends MoveState


func enter() -> void:
	super()
	current_move_speed = player.move_data.pushpull_speed


func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based on its logic
	var new_state = super.input(event)
	if new_state:
		return new_state

	return null


func physics_process(delta : float) -> BaseState:
	super(delta)
	if not player.nearest_pushable:
		return walk_state

	player.nearest_pushable.velocity.x = player.velocity.x

	return null
