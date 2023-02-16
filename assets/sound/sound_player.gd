extends Node

# SFX
const BLIP : AudioStream = preload("res://assets/sound/sounds/blip.wav")
const BUMP : AudioStream = preload("res://assets/sound/sounds/bump.wav")
const CLICK : AudioStream = preload("res://assets/sound/sounds/click.wav")
const HANDLE : AudioStream = preload("res://assets/sound/sounds/handle.wav")
const UNLOCK : AudioStream = preload("res://assets/sound/sounds/unlock.wav")
const STONE_SLIDE : AudioStream = preload("res://assets/sound/sounds/stone_slide.wav")

const HURT : AudioStream = preload("res://assets/sound/sounds/hurt.wav")
const HEAL : AudioStream = preload("res://assets/sound/sounds/heal.wav")
const JUMP : AudioStream = preload("res://assets/sound/sounds/jump2.wav")
const BOOM : AudioStream = preload("res://assets/sound/sounds/boom.wav")

const COIN : AudioStream = preload("res://assets/sound/sounds/coin.wav")
const DIAMOND : AudioStream = preload("res://assets/sound/sounds/diamond.wav")

const LOSE : AudioStream = preload("res://assets/sound/sounds/lose.wav")
const RESPAWN : AudioStream = preload("res://assets/sound/sounds/respawn.wav")
const SCENETRANSITION : AudioStream = preload("res://assets/sound/sounds/scene_transition.wav")
const CHECKPOINT : AudioStream = preload("res://assets/sound/sounds/checkpoint.wav")

# MUSIC
const INTRO : AudioStream= preload("res://assets/sound/songs/Adventure Meme.mp3")
const ADVENTURE : AudioStream = preload("res://assets/sound/songs/Adventures in Adventureland.mp3")
const DUNGEON : AudioStream= preload("res://assets/sound/songs/8bit Dungeon Level.mp3")

@onready var audio_players : Node = $AudioPlayers
@onready var song_audio_player: AudioStreamPlayer = $SongAudioStreamPlayer


func play_sound(sound : AudioStream) -> void:
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break


func play_song(song : AudioStream) -> void:
	if song_audio_player.stream != song:
		song_audio_player.stream = song
		song_audio_player.play()
