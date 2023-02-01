@tool
extends StaticBody2D

#@onready var path_2d: Path2D = $Path2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var line_2d: Line2D = $Line2D

var path_2d : Path2D = null


func _ready() -> void:
	update_configuration_warnings()

	if path_2d:
		var curve : Curve2D = path_2d.curve
		if curve:
			var polygon : PackedVector2Array = curve.get_baked_points()
			collision_polygon_2d.polygon = polygon
			polygon_2d.polygon = polygon
			line_2d.points = polygon

			polygon_2d.visible = true
			line_2d.visible = true


func _get_configuration_warnings() -> PackedStringArray:
	var warnings : PackedStringArray = PackedStringArray()

	if not path_2d:
		warnings.append("A Path2d is required to build the curved terrain")
		warnings.append("Add a Path2d as a child of this node")

	return warnings


func _on_child_entered_tree(node: Node) -> void:
	var contains_path : bool = false
	for child_node in get_children():
		if child_node is Path2D:
			contains_path = true


func _on_child_exiting_tree(node: Node) -> void:
	print("Buy")
