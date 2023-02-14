extends Resource
class_name GameData

const main_menu : String = "res://assets/GUI/menus/main_menu.tscn"
const level1 : String = "res://assets/world/levels/level01.tscn"
const level2 : String = "res://assets/world/levels/level02.tscn"
const level3 : String = "res://assets/world/levels/level03.tscn"

var current_level : String = ""
var player_position : Vector2 = Vector2.ZERO

var player_health : float = 3.0
var player_max_health : float = 3.0

var player_coins : int = 0
var player_diamonds : int = 0

var restore_player_position : bool = false


func to_dict() -> Dictionary:
	return {
		"current_level": current_level,
		"player_x": player_position.x,
		"player_y": player_position.y,

		"player_health": player_health,
		"player_max_health": player_max_health,

		"player_coins": player_coins,
		"player_diamonds": player_diamonds,
	}


func from_dict(data : Dictionary) -> void:
	current_level = data.current_level
	player_position = Vector2(data.player_x, data.player_y)

	player_health = data.player_health
	player_max_health = data.player_max_health

	player_coins = data.player_coins
	player_diamonds = data.player_diamonds
