extends Activator

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	#TODO: Find out why this is necessary
	animated_sprite.play_backwards("trigger")


func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body is Player:
		activate()


func _on_body_exited(body: Node2D) -> void:
	super(body)
	if body is Player:
		deactivate()


func trigger() -> void:
	super()
	pass


func activate() -> void:
	super()
	animated_sprite.play("trigger")
	SoundPlayer.play_sound(SoundPlayer.CLICK)


func deactivate() -> void:
	super()
	animated_sprite.play_backwards("trigger")
	SoundPlayer.play_sound(SoundPlayer.CLICK)
