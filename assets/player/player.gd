class_name Player
extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var move_data : PlayerMovementData = preload("res://assets/player/resources/pmd_slow.tres") as PlayerMovementData

var jump_count : int = 0
var buffered_jump : bool = false
var coyote_jump : bool = false

@onready var animations : AnimatedSprite2D = $Animations
@onready var states : StateManager = $state_manager
@onready var remote_transform : RemoteTransform2D = $RemoteTransform2D
@onready var ladder_check : RayCast2D = $LadderCheck
@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var coyote_jump_timer : Timer = $CoyoteJumpTimer

var current_door : Door = null 

@export var skins: Array[SpriteFrames] = []
var current_skin = 0

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)
	animations.frames = skins[0]


func connect_camera(camera: Camera2D):
	remote_transform.remote_path = camera.get_path()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("cycle_skin"):
		cycle_skin()

	if Input.is_action_pressed("move_up") and current_door != null:
		current_door.enter_door()

	states.input(event)


func cycle_skin() -> void:
	if current_skin == skins.size() - 1:
		# Go back to the first one
		current_skin = 0
	else:
		# Move to the next skin
		current_skin += 1

	animations.frames = skins[current_skin]


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _process(delta: float) -> void:
	if jump_count > 0 and is_on_floor():
		jump_count = 0

	states.process(delta)


func take_damage() -> void:
	SoundPlayer.play_sound(SoundPlayer.LOSE)
	queue_free()
	Events.emit_signal("player_died")


func is_on_ladder() -> bool:
	if not ladder_check.is_colliding(): return false
	var collider = ladder_check.get_collider()
	if not collider is Ladder: return false

	return true


func _on_jump_buffer_timer_timeout() -> void:
	# TODO: Maybe the jump_buffer_time logic should belong to fall_state?
	# Create a Timer dynamically and buffer_jump on fall.exit() ?
	buffered_jump = false


func _on_coyote_jump_timer_timeout() -> void:
	coyote_jump = false
