class_name BaseCollectible
extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func can_collect(_character : Player) -> bool:
	return true


func on_collect(_character : Player) -> void:
	animation_player.play("collect")
	GameManager.set_collectible_state(name, true)


func _on_body_entered(body: Node2D) -> void:
	if can_collect(body):
		on_collect(body)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect":
		queue_free()
