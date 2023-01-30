class_name Diamong
extends BaseCollectible


func can_collect(character : Player) -> bool:
	if character is Player and GameManager.game_data.player_diamonds < 99:
		return true
	return false


func on_collect(character : Player) -> void:
	GameManager.game_data.player_diamonds += 1
	SoundPlayer.play_song(SoundPlayer.DIAMOND)
	Events.emit_signal("update_diamonds_ui")
	super(character)


func _on_body_entered(body: Node2D) -> void:
	super(body)
