extends CanvasLayer

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func play_enter_level():
	animation_player.play("EnterLevel")

func play_exit_level():
	animation_player.play("ExitLevel")
