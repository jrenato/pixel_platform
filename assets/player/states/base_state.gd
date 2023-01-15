class_name BaseState
extends Node

@export var animation_name : String

# Pass in a reference to the player's CharacterBody2D so that it can be used by the state
var player: Player

func enter() -> void:
	player.animations.play(animation_name)

func exit() -> void:
	pass

func input(_event : InputEvent) -> BaseState:
	return null

func process(_delta : float) -> BaseState:
	return null

func physics_process(_delta : float) -> BaseState:
	return null
