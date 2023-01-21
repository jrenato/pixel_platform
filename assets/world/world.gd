extends Node2D

@onready var player : CharacterBody2D = $Player
@onready var camera : Camera2D = $Camera2D


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	player.connect_camera(camera)
