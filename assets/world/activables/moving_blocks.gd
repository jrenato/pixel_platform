# TODO: Find out why preload conflicts with tool modes
@tool
extends Activable

const BLOCK_SCENE := preload("res://assets/world/blocks/block.tscn")

@onready var blocks: PathFollow2D = $Blocks
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var block_distance : int = 18 :
	set(value):
		block_distance = value
		if not Engine.is_editor_hint():
			await ready
		update_blocks()
	get:
		return block_distance


var direction_vector : Vector2 = Vector2.UP
@export_enum("Up", "Down", "Left", "Right") var direction: String = "Up" :
	set(value):
		direction = value
		if not Engine.is_editor_hint():
			await ready
		update_direction()
		update_blocks()
	get:
		return direction


@export var size : int = 1 :
	set(value):
		size = value
		if not Engine.is_editor_hint():
			await ready
		update_blocks()
	get:
		return size


func _ready() -> void:
	update_direction()
	update_blocks()


func add_blocks() -> void:
	for index in size:
		var block : Block = BLOCK_SCENE.instantiate()
		blocks.add_child(block)
		#blocks.call_deferred("add_child", block)
		position_block(block, index)


func remove_all_blocks() -> void:
	var block_list : Array[Node] = blocks.get_children()

	for block in block_list:
		blocks.remove_child(block)


func position_block(block : Block, index : int) -> void:
	if index == 1:
		update_block_distance(block)
	block.position = block_distance * direction_vector * index


func update_block_distance(block : Block) -> void:
	assert(direction_vector in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT])
	if direction_vector in [Vector2.UP, Vector2.DOWN]:
		if block_distance != block.get_pixel_width():
			block_distance = block.get_pixel_width()
	else:
		if block_distance != block.get_pixel_height():
			block_distance = block.get_pixel_height()


func update_blocks() -> void:
	remove_all_blocks()
	add_blocks()


func update_direction() -> void:
	match direction:
		"Up": direction_vector = Vector2.UP
		"Down": direction_vector = Vector2.DOWN
		"Left": direction_vector = Vector2.LEFT
		"Right": direction_vector = Vector2.RIGHT


func activate() -> void:
	super()
	if not animation_player.is_playing() or animation_player.get_playing_speed() < 0:
		animation_player.play("move")


func deactivate() -> void:
	super()
	if not animation_player.is_playing() or animation_player.get_playing_speed() > 0:
		animation_player.play_backwards("move")
