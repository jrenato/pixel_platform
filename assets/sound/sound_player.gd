extends Node

@onready var audio_stream_player : AudioStreamPlayer = $AudioPlayers/AudioStreamPlayer


func play_sound() -> void:
	audio_stream_player.play()
