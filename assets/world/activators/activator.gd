class_name Activator
extends Area2D

@export var activated : bool = false
@export var activable : Activable
# TODO: Research why this doesn't work
@export var activables : Array[Activable] = []


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
	if activable:
		activable.add_activation()
#	for activable in activables:
#		if activable is Activable:
#			var temp : Activable = activable
#			temp.activated = activated


func deactivate() -> void:
	activated = false
	if activable:
		activable.remove_activation()
#	for activable in activables:
#		if activable in Activable:
#			activable.activated = activated
