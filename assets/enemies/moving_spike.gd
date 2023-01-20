extends Path2D

enum ANIMATION_TYPE { LOOP, BOUNCE }
@export var animation_type : ANIMATION_TYPE

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	match animation_type:
		ANIMATION_TYPE.LOOP: animation_player.play("MoveLoop")
		ANIMATION_TYPE.BOUNCE: animation_player.play("MoveBounce")
