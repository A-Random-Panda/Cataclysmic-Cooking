extends Node

var scene_index := 0
var scene_locked := true

const MENU_SCENE_POS := Vector2(0, 0)
const VENTS_SCENE_POS := Vector2(2000, 0)
const SCENE_POS := [
	Vector2(4000, 0),  # ENTRANCE_SCENE_POS
	Vector2(6000, 0),  # FARM_SCENE_POS
	Vector2(8000, 0),  # KITCHEN_SCENE_POS
	Vector2(10000, 0)  # POT_SCENE_POS
]

var inventory: Inventory = preload("res://ui/inventory/inventory.tres")
var is_dragging := false

var on_vents_scene := false

var hovered_item: Item
var camera: Camera2D

var inventory_rect: Rect2

signal hovered_on_item(item: Item)
signal hovered_off_item(item: Item)

func _item_hovered(item: Item):
	hovered_item = item

func _item_unhovered(item: Item):
	hovered_item = null

signal display_flavor(flavor: Dictionary)

func next_scene() -> void:
	if scene_index < len(SCENE_POS)-1:
		scene_index += 1
		camera.move(SCENE_POS[scene_index])

		if scene_index > 0:
			inventory_visible.emit(true)
		else:
			inventory_visible.emit(false)
		if scene_index == 3:
			pot_stats_visible.emit(true)
		else:
			pot_stats_visible.emit(false)
		


func previous_scene() -> void:
	if scene_index > 0:
		scene_index -= 1
		camera.move(SCENE_POS[scene_index])

		if scene_index > 0:
			inventory_visible.emit(true)
		else:
			inventory_visible.emit(false)
		if scene_index == 3:
			pot_stats_visible.emit(true)
		else:
			pot_stats_visible.emit(false)

func vents_scene() -> void:
	camera.move(VENTS_SCENE_POS)
	on_vents_scene = true

func current_scene() -> void:
	camera.move(SCENE_POS[scene_index])

	if on_vents_scene:
		on_vents_scene = false

signal inventory_visible(state: bool)
signal pot_stats_visible(state: bool)

func get_vector_zero() -> Vector2:
	if scene_locked:
		return VENTS_SCENE_POS
	else:
		return SCENE_POS[scene_index]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hovered_on_item.connect(_item_hovered)
	hovered_off_item.connect(_item_unhovered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if !scene_locked:
		if event.is_action_pressed("left_arrow_key"):
			previous_scene()
		elif event.is_action_pressed("right_arrow_key"):
			next_scene()
