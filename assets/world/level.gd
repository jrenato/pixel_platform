extends Node2D

const player_scene = preload("res://assets/player/player.tscn")

#var spawn_position : Vector2 = Vector2.ZERO

@onready var player : Player = $Player
@onready var camera : Camera2D = $Camera2D
@onready var respawn_timer : Timer = $RespawnTimer

# TODO: This enum should be stored as a string
@export_enum("Adventure", "Dungeon") var song : int = 0


func _ready() -> void:
	# Disables mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Set default color for background
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)

	# Connects current camera to player's RemoteTransform2D
	player.connect_camera(camera)

	# Sets custom signals
	Events.connect("player_died", _on_player_died)
	Events.connect("update_checkpoint", _on_update_checkpoint)

	if GameManager.game_data.restore_player_position:
		# Restore player position from saved location
		player.position = GameManager.game_data.player_position
		GameManager.game_data.restore_player_position = false
	else:
		# Just update player start position in game data
		GameManager.game_data.player_position = player.position

	GameManager.write_data()

	# Remove what is already collected, activate what's activated etc
	update_level_items()

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
	respawn_player()


func respawn_player() -> void:
	SoundPlayer.play_sound(SoundPlayer.RESPAWN)
	player = player_scene.instantiate()
	add_child(player)
	player.position = GameManager.game_data.player_position
	player.connect_camera(camera)

	GameManager.game_data.player_health = GameManager.game_data.player_max_health
	Events.emit_signal("update_hearts_ui")


func _on_update_checkpoint(checkpoint_position) -> void:
	SoundPlayer.play_sound(SoundPlayer.CHECKPOINT)
	GameManager.game_data.player_position = checkpoint_position
	GameManager.write_data()


func update_level_items() -> void:
	for collectible in get_tree().get_nodes_in_group("collectibles"):
		var collected : bool = GameManager.get_collectible_state(collectible.name)
		if collected:
			collectible.queue_free()

	for activable in get_tree().get_nodes_in_group("activables"):
		var activated : bool = GameManager.get_collectible_state(activable.name)
		if activated:
			activable.activate()
