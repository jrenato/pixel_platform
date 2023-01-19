class_name Player
extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var move_data : PlayerMovementData = preload("res://assets/player/resources/pmd_slow.tres") as PlayerMovementData

var jump_count : int = 0

@onready var animations : AnimatedSprite2D = $animations
@onready var states : StateManager = $state_manager
@onready var ladder_check : RayCast2D = $LadderCheck

@export var skins: Array[SpriteFrames] = []
var current_skin = 0

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)
	animations.frames = skins[0]


func _unhandled_input(event: InputEvent) -> void:
	var handled = false

	if Input.is_action_just_pressed("cycle_skin"):
		handled = true
		cycle_skin()

	if not handled:
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


func is_on_ladder() -> bool:
	if not ladder_check.is_colliding(): return false
	var collider = ladder_check.get_collider()
	if not collider is Ladder: return false

	return true
