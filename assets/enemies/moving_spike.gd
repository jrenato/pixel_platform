@tool
extends Path2D

enum ANIMATION_TYPE { LOOP, BOUNCE }

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var speed : int = 50 : 
	set(value):
		speed = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
			await ready
			animation_player.playback_speed = speed / curve.get_baked_length() 
	get:
		return speed

@export var animation_type : ANIMATION_TYPE = ANIMATION_TYPE.LOOP :
	set(value):
		animation_type = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
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
