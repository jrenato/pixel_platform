extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(target : String, type: String = 'dissolve') -> void:
	if type == 'dissolve':
		transition_dissolve(target)
	else:
		transition_clouds(target)


func transition_dissolve(target: String) -> void:
	animation_player.play("dissolve")
	await animation_player.animation_finished
	animation_player.play_backwards("dissolve")
	get_tree().change_scene_to_file(target)


func transition_clouds(target: String) -> void:
	animation_player.play("clouds_in")
	await animation_player.animation_finished
	animation_player.play("clouds_out")
	get_tree().change_scene_to_file(target)
