extends BaseState

@export var fall_node : NodePath
@export var jump_node : NodePath

@onready var fall_state: BaseState = get_node(fall_node)
@onready var jump_state: BaseState = get_node(jump_node)


func enter() -> void:
	# This calls the base class enter function, which is necessary here
	# to make sure the animation switches
	super.enter()
	player.velocity = Vector2.ZERO


func physics_process(delta : float) -> BaseState:
	var move = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if move.length() == 0:
		player.animations.stop()
	else:
		player.animations.play()

	player.velocity = move * player.move_data.climb_speed
	player.move_and_slide()

	if Input.is_action_just_pressed("jump"):
		return jump_state

	if not player.is_on_ladder():
		return fall_state

	if player.is_on_floor() and Input.is_action_pressed("move_down"):
		return fall_state

	return null
