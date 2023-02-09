class_name MoveState
extends BaseState

@export var jump_node : NodePath
@export var fall_node : NodePath
@export var dash_node : NodePath
@export var idle_node : NodePath
@export var walk_node : NodePath
@export var run_node : NodePath
@export var climb_node : NodePath

@onready var jump_state : BaseState = get_node(jump_node)
@onready var fall_state : BaseState = get_node(fall_node)
@onready var idle_state : BaseState = get_node(idle_node)
@onready var dash_state : BaseState = get_node(dash_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var climb_state : BaseState = get_node(climb_node)

var current_move_speed : int = 0


func input(_event : InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("move_down"):
			player.position.y += 1
		else:
			return jump_state

	if Input.is_action_just_pressed("dash"):
		return dash_state

	var ladder_input : bool = Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")
	if player.is_on_ladder() and ladder_input:
		return climb_state

	return null


func process(_delta : float) -> BaseState:
	if player.buffered_jump:
		return jump_state
	return null


func physics_process(delta : float) -> BaseState:
	if !player.is_on_floor():
		# Enable Coyote Jump
		player.coyote_jump = true
		player.coyote_jump_timer.start()

		return fall_state

	var move = get_movement_input()

	player.velocity.x = move_toward(player.velocity.x, move * current_move_speed, player.move_data.friction * delta)
	player.velocity.y += player.gravity * delta

	if player.nearest_pushable:
		# Push it at the same speed as the player
		player.nearest_pushable.velocity.x = player.velocity.x

	player.move_and_slide()

	if move != 0:
		player.flip_player_h(move > 0)
	else:
		return idle_state

	return null


func get_movement_input() -> float:
	#TODO: Why get_axis doesn't work
#	return Input.get_axis("move_left", "move_right")
	if Input.is_action_pressed("move_left"):
		return -1.0
	elif Input.is_action_pressed("move_right"):
		return 1.0
	return 0.0
