extends MoveState


func enter() -> void:
	super()
	current_move_speed = player.move_data.pushpull_speed


func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based on its logic
	var new_state = super(event)
	if new_state:
		return new_state

	return null
