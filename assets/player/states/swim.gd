class_name SwimState
extends BaseState

@export var jump_node : NodePath
@onready var jump_state : BaseState = get_node(jump_node)

var current_move_speed : int = 0


func enter() -> void:
	super()
	current_move_speed = player.move_data.swim_speed


func input(_event : InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		SoundPlayer.play_sound(SoundPlayer.SWIM)
		player.velocity.y -= current_move_speed * 2

	return null


func physics_process(delta : float) -> BaseState:
	var move : Vector2 = get_movement_input()

	if move.x != 0:
		player.flip_player_h(move.x > 0)

	player.velocity.x = move_toward(player.velocity.x, move.x * current_move_speed, player.move_data.friction * delta)
	player.velocity.y = move_toward(player.velocity.y, move.y * current_move_speed + player.gravity, player.move_data.friction * delta)

	player.move_and_slide()

	if not player.is_in_water:
		return jump_state

	return null


func get_movement_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
#	if Input.is_action_pressed("move_left"):
#		return -1.0
#	elif Input.is_action_pressed("move_right"):
#		return 1.0
#	return 0.0
