extends BaseCollectible
class_name Diamond


func can_collect(character : Player) -> bool:
#	if character is Player and GameManager.game_data.player_diamonds < 99:
#		return true
#	return false
	return super(character)


func on_collect(character : Player) -> void:
#	GameManager.game_data.player_diamonds += 1
#	Events.emit_signal("update_diamonds_ui")
	SoundPlayer.play_sound(SoundPlayer.DIAMOND)
	super(character)


func _on_body_entered(body: Node2D) -> void:
	super(body)
