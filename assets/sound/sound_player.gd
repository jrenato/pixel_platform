extends Node

const HURT = preload("res://assets/sound/sounds/hurt.wav")
const JUMP = preload("res://assets/sound/sounds/jump2.wav")
const BOOM = preload("res://assets/sound/sounds/boom.wav")
const LOSE = preload("res://assets/sound/sounds/lose.wav")
const RESPAWN = preload("res://assets/sound/sounds/respawn.wav")
const CHECKPOINT = preload("res://assets/sound/sounds/checkpoint.wav")

@onready var audio_players : Node = $AudioPlayers


func play_sound(sound : AudioStream) -> void:
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break
