@tool
extends Path2D

enum ANIMATION_TYPE { LOOP, BOUNCE }

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var dynamic_terrain: StaticBody2D :
	set(value):
		dynamic_terrain = value
	get:
		return dynamic_terrain

@export var speed : int = 50 : 
	set(value):
		speed = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
			await ready
			animation_player.speed_scale = speed / curve.get_baked_length() 
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
	if animation_player:
		if not Engine.is_editor_hint():
			animation_player.speed_scale = speed / curve.get_baked_length()
	sync_curve_to_terrain()


func sync_curve_to_terrain() -> void:
	if dynamic_terrain:
		var terrain_curve : Curve2D = dynamic_terrain.get_curve()
		curve = terrain_curve
		position = dynamic_terrain.position


func set_animation_type() -> void:
	match animation_type:
		ANIMATION_TYPE.BOUNCE: animation_player.play("MoveBounce")
		ANIMATION_TYPE.LOOP: animation_player.play("MoveLoop")
