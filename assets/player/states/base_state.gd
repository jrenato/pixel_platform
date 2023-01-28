class_name BaseState
extends Node

@export var animation_name : String

# Pass in a reference to the player's CharacterBody2D so that it can be used by the state
var player: Player


func enter() -> void:
	# TODO: Keep an eye on this issue
	# https://github.com/godotengine/godot/pull/66219
	player.animations.frame = 1
	player.animations.play(animation_name)


func exit() -> void:
	pass


func input(_event : InputEvent) -> BaseState:
	return null


func process(_delta : float) -> BaseState:
	return null


func physics_process(_delta : float) -> BaseState:
	return null
