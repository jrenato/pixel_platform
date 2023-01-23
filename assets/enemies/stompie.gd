# @tool
# TODO: is it possible to detect collisions with a tilemap in editor?
extends Node2D

enum {HOVER, FALL, LAND, RISE}

var state := HOVER

@export var active : bool = true :
	set(value):
		active = value
		if Engine.is_editor_hint():
			PhysicsServer2D.set_active(active)
			await ready
			timer.start()
	get:
		return active

@export var wait_time : float = 1.0 :
	set(value):
		wait_time = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
			await ready
			timer.wait_time = wait_time
	get:
		return wait_time

@export var fall_speed : int = 200
@export var rise_speed : int = 50

@onready var start_position : Vector2 = global_position # Vector2(558, 522)
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var particles : GPUParticles2D = $GPUParticles2D
@onready var raycast : RayCast2D = $RayCast2D
@onready var timer : Timer = $Timer


func _ready() -> void:
	timer.wait_time = wait_time
	start_position = global_position # Vector2(558, 522)


func _physics_process(delta : float) -> void:
	match state:
		HOVER: hover_state(delta)
		FALL: fall_state(delta)
		LAND: land_state(delta)
		RISE: rise_state(delta)


func hover_state(_delta : float) -> void:
	if timer.is_stopped() and active:
		timer.start()


func fall_state(delta : float) -> void:
	position.y += fall_speed * delta
	if raycast.is_colliding():
		var collision_point : Vector2 = raycast.get_collision_point()
		position.y = collision_point.y
		particles.emitting = true
		SoundPlayer.play_sound(SoundPlayer.BOOM)
		state = LAND


func land_state(_delta : float) -> void:
	if timer.is_stopped():
		timer.start()


func rise_state(delta : float) -> void:
	position.y = move_toward(position.y, start_position.y, rise_speed * delta)
	if position.y == start_position.y:
		state = HOVER


func _on_timer_timeout():
	match state:
		HOVER:
			state = FALL
			animated_sprite.play("Falling")
			print("Falling")
		LAND:
			state = RISE
			animated_sprite.play("Rising")
			particles.emitting = false
			print("Rising")
