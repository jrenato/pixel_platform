extends Activator

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var key_id : String = ""


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not key_id.is_empty():
		var key_item : Item = GameManager.inventory_manager.get_item_with_id(key_id)
		if key_item != null:
			GameManager.inventory_manager.remove_selected_item()
			Events.emit_signal("update_inventory_ui")
			animation_player.play("unlock")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SoundPlayer.play_sound(SoundPlayer.UNLOCK)
	activate()
