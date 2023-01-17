extends BaseState

@export var run_node : NodePath
@export var walk_node : NodePath
@export var idle_node : NodePath

@onready var run_state : BaseState = get_node(run_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var idle_state : BaseState = get_node(idle_node)


func physics_process(delta : float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.animations.flip_h = false
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.animations.flip_h = true

	player.velocity.x = move_toward(player.velocity.x, move * player.move_data.fall_move_speed, player.move_data.friction)
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		else:
			return idle_state

	return null
