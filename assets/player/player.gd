class_name Player
extends CharacterBody2D

@export var move_data : Resource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations : AnimatedSprite2D = $animations
@onready var states : StateManager = $state_manager

@onready var green_skin : SpriteFrames = load("res://assets/player/skins/PlayerGreenSkin.tres")
@onready var blue_skin : SpriteFrames = load("res://assets/player/skins/PlayerBlueSkin.tres")
@onready var orange_skin : SpriteFrames = load("res://assets/player/skins/PlayerOrangeSkin.tres")
@onready var pink_skin : SpriteFrames = load("res://assets/player/skins/PlayerPinkSkin.tres")
@onready var yellow_skin : SpriteFrames = load("res://assets/player/skins/PlayerYellowSkin.tres")

@onready var skins = [green_skin, blue_skin, orange_skin, pink_skin, yellow_skin]

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
	states.process(delta)
