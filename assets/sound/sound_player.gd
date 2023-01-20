extends Node

const HURT = preload("res://assets/sound/sounds/hurt.wav")
const JUMP = preload("res://assets/sound/sounds/jump.wav")
const BOOM = preload("res://assets/sound/sounds/boom.wav")

@onready var audio_players : Node = $AudioPlayers


func play_sound(sound : AudioStream) -> void:
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break
