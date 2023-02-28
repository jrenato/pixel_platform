extends Path2D

enum STATE { PATROLLING, CHASING }

var state : STATE = STATE.PATROLLING

@onready var bat_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var patrol_point: PathFollow2D = $PathFollow2D


func _process(delta: float) -> void:
	if state == STATE.PATROLLING:
		bat_sprite.position = bat_sprite.position.move_toward(patrol_point.position, delta * 80)
