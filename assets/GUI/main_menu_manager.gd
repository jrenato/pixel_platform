extends CanvasLayer

@onready var main_menu: Control = $Main
@onready var settings_menu: Control = $Settings


func _ready() -> void:
	main_menu.settings_menu = settings_menu
	settings_menu.parent_menu = main_menu
	main_menu.init()
