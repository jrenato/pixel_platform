extends Node2D

const player_scene = preload("res://assets/player/player.tscn")

#var spawn_position : Vector2 = Vector2.ZERO

@onready var player : Player = $Player
@onready var camera : Camera2D = $Camera2D
@onready var respawn_timer : Timer = $RespawnTimer

# TODO: This enum should be stored as a string
@export_enum("Adventure", "Dungeon") var song : int = 0


func _ready() -> void:
	# Set default color for background
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)

	# Connects current camera to player's RemoteTransform2D
	player.connect_camera(camera)

	# Sets custom signals
	Events.connect("player_died", _on_player_died)
	Events.connect("update_checkpoint", _on_update_checkpoint)

	if GameManager.game_data.update_player_position:
		# Positions player from saved location
		GameManager.game_data.update_player_position = false
		player.position = GameManager.game_data.player_position
	else:
		# Updates player start position in game data
		GameManager.game_data.player_position = player.position
		GameManager.write_data()

	# Starts or resumes level music
	_play_song()


func _play_song() -> void:
	match song:
		0:
			SoundPlayer.play_song(SoundPlayer.ADVENTURE)
		1:
			SoundPlayer.play_song(SoundPlayer.DUNGEON)


func _on_player_died() -> void:
	respawn_timer.start()
	await respawn_timer.timeout

	SoundPlayer.play_sound(SoundPlayer.RESPAWN)
	player = player_scene.instantiate()
	add_child(player)
	player.position = GameManager.game_data.player_position
	player.connect_camera(camera)

func _on_update_checkpoint(checkpoint_position) -> void:
	SoundPlayer.play_sound(SoundPlayer.CHECKPOINT)
	GameManager.game_data.player_position = checkpoint_position
	GameManager.write_data()
