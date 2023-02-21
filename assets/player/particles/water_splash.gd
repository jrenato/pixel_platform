extends GPUParticles2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = lifetime


func start() -> void:
	emitting = true
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
