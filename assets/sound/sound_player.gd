extends Node

const HURT : AudioStream = preload("res://assets/sound/sounds/hurt.wav")
const JUMP : AudioStream = preload("res://assets/sound/sounds/jump2.wav")
const BOOM : AudioStream = preload("res://assets/sound/sounds/boom.wav")
const LOSE : AudioStream = preload("res://assets/sound/sounds/lose.wav")
const RESPAWN : AudioStream = preload("res://assets/sound/sounds/respawn.wav")
const SCENETRANSITION : AudioStream = preload("res://assets/sound/sounds/scene_transition.wav")
const CHECKPOINT : AudioStream = preload("res://assets/sound/sounds/checkpoint.wav")

const ADVENTURE : AudioStream = preload("res://assets/sound/songs/Adventures in Adventureland.mp3")
const DUNGEON : AudioStream= preload("res://assets/sound/songs/8bit Dungeon Level.mp3")

@onready var audio_players : Node = $AudioPlayers
@onready var song_audio_player: AudioStreamPlayer = $SongAudioStreamPlayer

var current_song : String = ""

func play_sound(sound : AudioStream) -> void:
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break


func play_song(song : String) -> void:
	if song.is_empty() or current_song == song:
		return

	current_song = song

	# Default
	song_audio_player.stream = ADVENTURE

	match song:
		"Dungeon":
			song_audio_player.stream = DUNGEON
	
	song_audio_player.play()
