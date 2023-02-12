extends BaseState

@export var idle_node : NodePath
@export var walk_node : NodePath
@export var jump_node : NodePath
@export var fall_node : NodePath

@onready var idle_state : BaseState = get_node(idle_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var jump_state : BaseState = get_node(jump_node)
@onready var fall_state : BaseState = get_node(fall_node)

var current_move_speed : int = 0
var current_direction : int = 0


func enter() -> void:
	super()
	current_move_speed = player.move_data.pushpull_speed
	current_direction = get_movement_input()


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("move_down"):
			player.position.y += 1
		else:
			return jump_state
			
	return null


func physics_process(delta : float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input()

	if move != 0:
		player.flip_player_h(move > 0)
		if move != current_direction:
			return walk_state
	else:
		return idle_state

	player.velocity.x = move * current_move_speed
	player.velocity.y += player.gravity * delta

	if player.is_near_pushable():
		player.nearest_pushable.velocity.x = player.velocity.x
	else:
		# TODO: This helps is_near_pushable() returning false positives.
		# Keep an eye on it.
		return walk_state

	player.move_and_slide()

	return null


func get_movement_input() -> float:
	#TODO: Why get_axis doesn't work
#	return Input.get_axis("move_left", "move_right")
	if Input.is_action_pressed("move_left"):
		return -1.0
	elif Input.is_action_pressed("move_right"):
		return 1.0
	return 0.0
