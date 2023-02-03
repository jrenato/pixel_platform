class_name Activable
extends Node2D

@onready var block_group: Node2D = $BlockGroup

var block_scene : Resource = preload("res://assets/world/blocks/block.tscn")

@export var size : int = 1


func _ready() -> void:
	remove_all_blocks()
	add_blocks()


func add_blocks() -> void:
	for i in size:
		var block = block_scene.instantiate()
		block_group.add_child(block)


func remove_all_blocks() -> void:
	var block_children : Array[Node] = block_group.get_children()
	for block_child in block_children:
		block_group.remove_child(block_child)


func activate() -> void:
	pass


func deactivate() -> void:
	pass
