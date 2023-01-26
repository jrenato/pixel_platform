extends BaseState

@export var jump_node : NodePath
@export var fall_node : NodePath
@export var walk_node : NodePath
@export var climb_node : NodePath
@export var run_node : NodePath
@export var dash_node : NodePath

@onready var jump_state : BaseState = get_node(jump_node)
@onready var fall_state : BaseState = get_node(fall_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var climb_state : BaseState = get_node(climb_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var dash_state : BaseState = get_node(dash_node)


func enter() -> void:
	super.enter()
	#player.velocity.x = 0


func input(_event : InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state
	elif Input.is_action_just_pressed("dash"):
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
	player.velocity.x = move_toward(player.velocity.x, 0, player.move_data.friction * delta)
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if !player.is_on_floor():
		return fall_state
	return null
