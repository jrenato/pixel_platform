class_name Player
extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var default_gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var water_gravity : int = floor(default_gravity / 100)

var gravity : int = default_gravity

@export var move_data : PlayerMovementData = preload("res://assets/player/resources/pmd_slow.tres") as PlayerMovementData

@onready var water_splash_scene : PackedScene = preload("res://assets/player/particles/water_splash.tscn")

var jump_count : int = 0
var buffered_jump : bool = false
var coyote_jump : bool = false

@onready var state_manager: Node = $state_manager
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var remote_transform : RemoteTransform2D = $RemoteTransform2D

@onready var states : StateManager = $state_manager
@onready var ladder_check : RayCast2D = $LadderCheck
@onready var push_check: RayCast2D = $PushCheck
@onready var water_detection: Area2D = $WaterDetectionArea2D

@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var coyote_jump_timer : Timer = $CoyoteJumpTimer

@onready var hurt_timer: Timer = $HurtTimer
@export var hurt_duration : int = 1

var nearest_door : Door = null
var nearest_activator : Activator = null
var nearest_pushable : CharacterBody2D = null

var is_pulling : bool = false

var is_in_water : bool = false :
	set(value):
		is_in_water = value
		cross_water_surface()
	get:
		return is_in_water

var is_on_coil : bool = false

@export var skins: Array[SpriteFrames] = []
var current_skin = 0


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	states.init(self)
	animated_sprite.frames = skins[0]
	hurt_timer.wait_time = hurt_duration


func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	is_near_pushable()


func _process(delta: float) -> void:
	if jump_count > 0 and is_on_floor():
		jump_count = 0

	states.process(delta)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("cycle_skin"):
		cycle_skin()

	if Input.is_action_pressed("move_up") and nearest_door != null:
		nearest_door.enter_door()

	if Input.is_action_just_pressed("interact") and nearest_activator != null:
		nearest_activator.trigger()

	if Input.is_action_pressed("interact") and is_near_pushable():
		is_pulling = true
	else:
		is_pulling = false

	if Input.is_action_just_pressed("swap_item"):
		GameManager.inventory_manager.swap_items()
		Events.emit_signal("update_inventory_ui")

	states.input(event)


func connect_camera(camera: Camera2D):
	remote_transform.remote_path = camera.get_path()
	camera.make_current()


func flip_player_h(flipped : bool) -> void:
	animated_sprite.flip_h = flipped
	if flipped:
		push_check.target_position = Vector2(10, 0)
	else:
		push_check.target_position = Vector2(-10, 0)


func get_player_direction() -> int:
	if animated_sprite.flip_h:
		return 1
	return -1


func cycle_skin() -> void:
	if current_skin == skins.size() - 1:
		# Go back to the first one
		current_skin = 0
	else:
		# Move to the next skin
		current_skin += 1

	animated_sprite.frames = skins[current_skin]


func take_damage(damage : float) -> void:
	hurt_timer.start()
	animation_player.play("hurt")
	SoundPlayer.play_sound(SoundPlayer.HURT)

	set_collision_layer_value(2, false)

	GameManager.game_data.player_health -= damage
	Events.emit_signal("update_hearts_ui")
	
	if GameManager.game_data.player_health <= 0.0:
		die()


func die() -> void:
	GameManager.game_data.player_health = 0
	Events.emit_signal("update_hearts_ui")

	Events.emit_signal("player_died")

	SoundPlayer.play_sound(SoundPlayer.LOSE)
	queue_free()


func is_on_ladder() -> bool:
	if not ladder_check.is_colliding(): return false
	var collider = ladder_check.get_collider()
	if not collider is Ladder: return false

	return true


func is_near_pushable() -> bool:
	# TODO: There's probably a better way to do this
	if nearest_pushable:
		nearest_pushable.player_pushing = null
	nearest_pushable = null

	if not push_check.is_colliding():
		return false

	var collider = push_check.get_collider()
	if not collider or not collider.is_in_group("Pushables"):
		return false

	# TODO: This method returns true even when it shouldn't
	# This might be a v4 bug. Keep an eye on it.
	nearest_pushable = collider
	nearest_pushable.player_pushing = self
	return true


func _on_jump_buffer_timer_timeout() -> void:
	buffered_jump = false


func _on_coyote_jump_timer_timeout() -> void:
	coyote_jump = false


func _on_hurt_timer_timeout() -> void:
	animation_player.stop()
	set_collision_layer_value(2, true)


func _on_hit_block_area_2d_body_entered(body: Node2D) -> void:
	if body is HitBlock and body.is_in_group("HitBlocks") and velocity.y <= 0:
		body.hit()


func cross_water_surface() -> void:
	SoundPlayer.play_sound(SoundPlayer.WATER_SPLASH)
	var water_splash : GPUParticles2D = water_splash_scene.instantiate()
	get_parent().add_child(water_splash)
	water_splash.position = Vector2(global_position.x, global_position.y - 10)
	water_splash.start()


func _on_water_detector_area_2d_body_entered(_body: Node2D) -> void:
	if not is_in_water:
		var bodies : Array[Node2D] = water_detection.get_overlapping_bodies()
		
		if bodies.size() > 0:
			is_in_water = true
			gravity = water_gravity
			velocity.y = 0


func _on_water_detector_area_2d_body_exited(_body: Node2D) -> void:
	if is_in_water:
		var bodies : Array[Node2D] = water_detection.get_overlapping_bodies()
		
		if bodies.size() == 0:
			is_in_water = false
			gravity = default_gravity
