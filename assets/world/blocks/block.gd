extends StaticBody2D
class_name Block

@onready var sprite : Sprite2D = $Sprite2D


func get_pixel_width() -> int:
	if sprite:
		return int(sprite.region_rect.size.x)
	return 0


func get_pixel_height() -> int:
	if sprite:
		return int(sprite.region_rect.size.y)
	return 0
