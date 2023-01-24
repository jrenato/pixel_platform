extends Node2D

const player_scene = preload("res://assets/player/player.tscn")

var spawn_position : Vector2 = Vector2.ZERO

@onready var player : Player = $Player
@onready var camera : Camera2D = $Camera2D
@onready var respawn_timer : Timer = $RespawnTimer

#@export_enum("Adventure", "Dungeon") var song : String

@export var song : String = "Adventure"

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	player.connect_camera(camera)
	Events.connect("player_died", _on_player_died)
	Events.connect("update_checkpoint", _on_update_checkpoint)
	spawn_position = player.position
	SoundPlayer.play_song(song)


func _on_player_died() -> void:
	respawn_timer.start()
	await respawn_timer.timeout

	SoundPlayer.play_sound(SoundPlayer.RESPAWN)
	player = player_scene.instantiate()
	add_child(player)
	player.position = spawn_position
	player.connect_camera(camera)

func _on_update_checkpoint(checkpoint_position) -> void:
	SoundPlayer.play_sound(SoundPlayer.CHECKPOINT)
	spawn_position = checkpoint_position
