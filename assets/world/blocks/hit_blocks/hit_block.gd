extends StaticBody2D
class_name HitBlock

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enabled_sprite_2d: Sprite2D = $EnabledSprite2D
@onready var disabled_sprite_2d: Sprite2D = $DisabledSprite2D
@onready var spawn_node_2d: Node2D = $SpawnNode2D

@export var spawn_item : PackedScene
@export var break_particles : PackedScene
@export var breakable : bool = false

var active : bool = true :
	set(value):
		active = value
		enabled_sprite_2d.visible = active
		disabled_sprite_2d.visible = !active
	get:
		return active


func _ready() -> void:
	active = true


func hit() -> void:
	if breakable:
		break_block()
		return

	if active:
		active = false
		bump_block()


func bump_block() -> void:
		animation_player.play("hit")

		if spawn_item:
			var item : Node2D = spawn_item.instantiate()
			spawn_node_2d.add_child(item)


func break_block() -> void:
	if break_particles:
		var particles : GPUParticles2D = break_particles.instantiate()
		get_parent().add_child(particles)
		particles.position = position
		particles.emitting = true

	call_deferred("queue_free")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	pass
