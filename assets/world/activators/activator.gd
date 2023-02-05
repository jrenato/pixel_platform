class_name Activator
extends Area2D

@export var activated : bool = false

@export var activable1 : Activable
@export var activable2 : Activable
@export var activable3 : Activable
# TODO: Keep an eye on this issue
# https://github.com/godotengine/godot/issues/62916
@export var activables : Array[Activable]


func _on_body_entered(_body: Node2D) -> void:
	pass


func _on_body_exited(_body: Node2D) -> void:
	pass


func trigger() -> void:
	if not activated:
		activate()
	else:
		deactivate()


func activate() -> void:
	activated = true
	for activable in [activable1, activable2, activable3]:
		if activable:
			activable.add_activation()
#	for activable in activables:
#		if activable is Activable:
#			var temp : Activable = activable
#			temp.activated = activated


func deactivate() -> void:
	activated = false
	for activable in [activable1, activable2, activable3]:
		if activable:
			activable.remove_activation()
#	for activable in activables:
#		if activable in Activable:
#			activable.activated = activated
