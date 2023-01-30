class_name Coin
extends BaseCollectible


func can_collect(character : Player) -> bool:
	if character is Player and GameManager.game_data.player_coins < 999:
		return true
	return false


func on_collect(character : Player) -> void:
	GameManager.game_data.player_coins += 1
	SoundPlayer.play_song(SoundPlayer.COIN)
	Events.emit_signal("update_coins_ui")
	super(character)


func _on_body_entered(body: Node2D) -> void:
	super(body)
