class_name HeartContainer
extends Control

@export var heart_empty : Texture = preload("res://assets/GUI/atlases/heartempty_atlas_texture.tres")
@export var heart_half : Texture = preload("res://assets/GUI/atlases/hearthalf_atlas_texture.tres")
@export var heart_full : Texture = preload("res://assets/GUI/atlases/heartfull_atlas_texture.tres")

@onready var heart_texture_rect: TextureRect = $HeartTextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var value : float = 0.0 :
	set(new_value):
		var mode : String = "increase"
		if new_value < value:
			mode = "decrease"
		value = new_value
		update_heart(mode)
	get:
		return value


func _ready() -> void:
	update_heart("")


func update_heart(mode : String = "") -> void:
	if value == 1.0:
		heart_texture_rect.texture = heart_full
	elif value >= 0.5:
		heart_texture_rect.texture = heart_half
	else:
		heart_texture_rect.texture = heart_empty

	match mode:
		"increase":
			animation_player.play("increase")
		"decrease":
			animation_player.play("decrease")
