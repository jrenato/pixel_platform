class_name Door
extends Area2D

@export_file("*.tscn") var target_level_path = ""

@onready var enter_label: Label = $EnterLabel


func _ready() -> void:
	enter_label.visible = false


func enter_door() -> void:
	GameManager.game_data.current_level = target_level_path
	GameManager.write_data()
	SoundPlayer.play_sound(SoundPlayer.SCENETRANSITION)
	SceneTransition.change_scene(target_level_path, "clouds")


func _on_body_entered(body: Node2D) -> void:
	if not body is Player or target_level_path.is_empty():
		return

	body.nearest_door = self
	enter_label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if not body is Player:
		return

	body.nearest_door = null
	enter_label.visible = false
