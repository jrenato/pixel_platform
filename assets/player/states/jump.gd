extends BaseState

@export var fall_node : NodePath
@export var jump_node : NodePath
@export var run_node : NodePath
@export var walk_node : NodePath
@export var idle_node : NodePath
@export var climb_node : NodePath

@onready var fall_state: BaseState = get_node(fall_node)
@onready var jump_state: BaseState = get_node(jump_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var climb_state : BaseState = get_node(climb_node)

var jump_input_released : bool = false


func enter() -> void:
	super.enter()
	SoundPlayer.play_sound(SoundPlayer.JUMP)
	var current_jump_force : int = -player.move_data.jump_force

	if player.is_on_coil:
		current_jump_force = -player.move_data.jump_coil_force

	player.velocity.y = current_jump_force
	player.jump_count += 1
	player.buffered_jump = false


func input(_event : InputEvent) -> BaseState:
	# Climb while jumping
	var ladder_input : bool = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")
	if player.is_on_ladder() and ladder_input:
		return climb_state

	# Double jump
	if Input.is_action_just_pressed("jump") and player.jump_count < player.move_data.max_jump_count:
		return jump_state

	return null


func physics_process(delta : float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.flip_player_h(false)
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.flip_player_h(true)

	player.velocity.x = move_toward(player.velocity.x, move * player.move_data.jump_move_speed, player.move_data.friction * delta)
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.velocity.y > 0:
		return fall_state

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		return idle_state

	return null
