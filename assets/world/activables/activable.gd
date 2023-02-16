class_name Activable
extends Node2D


var activated : bool = false

@export var one_way_activation : bool = false

@export var activations : int = 0 :
	set(value):
		activations = value
		update_activation()
	get:
		return activations


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func add_activation() -> void:
	activations += 1


func remove_activation() -> void:
	if not one_way_activation or activations > 1:
		# If one_way_activation, never drop to zero activations
		activations -= 1


func update_activation() -> void:
	assert(activations >= 0)

	if activations > 0 and not activated:
		activate()

	if activations == 0 and activated:
		deactivate()


func activate() -> void:
	activated = true


func deactivate() -> void:
	activated = false
