class_name Heart
extends BaseCollectible

@export var health : float = 1.0


func can_collect(character : Player) -> bool:
	var max_health : float = GameManager.game_data.player_max_health
	var current_health : float = GameManager.game_data.player_health
	if character is Player and current_health < max_health:
		return true
	return false


func on_collect(character : Player) -> void:
	# Clamping health to max_health
	var max_health : float = GameManager.game_data.player_max_health
	var new_health : float = clamp(GameManager.game_data.player_health + health, 0, max_health)

	GameManager.game_data.player_health = new_health
	
	SoundPlayer.play_song(SoundPlayer.HEAL)
	Events.emit_signal("update_hearts_ui")
	super(character)


func _on_body_entered(body: Node2D) -> void:
	super(body)
