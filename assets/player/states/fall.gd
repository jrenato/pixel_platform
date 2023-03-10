extends BaseState

@export var jump_node : NodePath
@export var run_node : NodePath
@export var walk_node : NodePath
@export var idle_node : NodePath
@export var climb_node : NodePath
@export var swim_node : NodePath

@onready var jump_state : BaseState = get_node(jump_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var idle_state : BaseState = get_node(idle_node)
@onready var climb_state : BaseState = get_node(climb_node)
@onready var swim_state : BaseState = get_node(swim_node)


func input(_event : InputEvent) -> BaseState:
	# Climb
	var ladder_input : bool = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")
	if player.is_on_ladder() and ladder_input:
		return climb_state

	if Input.is_action_just_pressed("jump"):
		# Double jump
		if player.jump_count > 0 and player.jump_count < player.move_data.max_jump_count:
			return jump_state
		# Coyote Jump
		elif player.coyote_jump:
			return jump_state
		else:
			# Prepare buffered jump
			player.buffered_jump = true
			player.jump_buffer_timer.start()


	return null


func physics_process(delta : float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.flip_player_h(false)
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.flip_player_h(true)

	player.velocity.x = move_toward(player.velocity.x, move * player.move_data.fall_move_speed, player.move_data.friction * delta)
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		else:
			return idle_state

	if player.is_in_water:
		return swim_state

	return null
