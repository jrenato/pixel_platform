extends Area2D
class_name BaseCollectible

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var item_id : String = ""


func can_collect(_character : Player) -> bool:
	if item_id == "":
		return true

	if GameManager.inventory_manager.has_empty_slot():
		return true

	return false


func on_collect(_character : Player) -> void:
	# TODO: There might be a better way to do this
	var collected : bool = true

	if item_id != "":
		# Collected only if succesfully added to inventory
		collected = GameManager.inventory_manager.add_item_with_id(item_id)
		if collected:
			Events.emit_signal("update_inventory_ui")

	if collected:
		animation_player.play("collect")
		GameManager.set_collectible_state(name, true)


func _on_body_entered(body: Node2D) -> void:
	if can_collect(body):
		on_collect(body)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect":
		queue_free()
