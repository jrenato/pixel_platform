@tool
extends Path2D

enum ANIMATION_TYPE { LOOP, BOUNCE }

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var speed : int = 50 : 
	set(value):
		animation_type = value
		# Check this issue
		# https://github.com/godotengine/godot-proposals/issues/325
		# It should be fixed with @onready setters and getters
		if not is_inside_tree():
			await ready
		animation_player.playback_speed = speed / curve.get_baked_length() 
	get:
		return animation_type

@export var animation_type : ANIMATION_TYPE = ANIMATION_TYPE.LOOP :
	set(value):
		animation_type = value
		# Check this issue
		# https://github.com/godotengine/godot-proposals/issues/325
		# It should be fixed with @onready setters and getters
		if not is_inside_tree():
			await ready
		set_animation_type()
	get:
		return animation_type


func _ready() -> void:
	set_animation_type()
	animation_player.playback_speed = speed / curve.get_baked_length() 


func set_animation_type() -> void:
	match animation_type:
		ANIMATION_TYPE.BOUNCE: animation_player.play("MoveBounce")
		ANIMATION_TYPE.LOOP: animation_player.play("MoveLoop")
