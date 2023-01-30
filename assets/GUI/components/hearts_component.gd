extends PanelContainer

const heart_container_scene : PackedScene = preload("res://assets/GUI/components/heart_container.tscn")
@onready var h_box_container: HBoxContainer = $VBoxContainer/HBoxContainer

var hearts : Array[HeartContainer] = []


func _ready() -> void:
	Events.connect("update_hearts_ui", _on_update_hearts_ui)
	rebuild_containers()
	update_container_values()


func rebuild_containers() -> void:
	for container in h_box_container.get_children():
		h_box_container.remove_child(container)
		container.queue_free()

	for i in GameManager.game_data.player_max_health:
		var temp_heart : HeartContainer = heart_container_scene.instantiate()
		h_box_container.add_child(temp_heart)
		hearts.append(temp_heart)


func update_container_values() -> void:
	var temp_health = GameManager.game_data.player_health
	
	for heart in hearts:
		if temp_health >= 1.0:
			temp_health -= 1.0
			heart.value = 1.0
		elif temp_health >= 0.5:
			temp_health -= 0.5
			heart.value = 0.5
		else:
			heart.value = 0.0


func _on_update_hearts_ui() -> void:
	update_container_values()
