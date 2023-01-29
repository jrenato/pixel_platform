class_name GameData
extends Node

const main_menu : String = "res://assets/GUI/menus/main_menu.tscn"
const level1 : String = "res://assets/world/levels/level01.tscn"
const level2 : String = "res://assets/world/levels/level02.tscn"
const level3 : String = "res://assets/world/levels/level03.tscn"

var current_level : String = ""
var player_position : Vector2 = Vector2.ZERO

var update_player_position : bool = false
