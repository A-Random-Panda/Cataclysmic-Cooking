extends Node

var inventory: Inventory = preload("res://ui/inventory/inventory.tres")
var is_dragging := false
var on_emergy

var hovered_item: Item

signal hovered_on_item(item: Item)
signal hovered_off_item(item: Item)

func _item_hovered(item: Item):
	hovered_item = item

func _item_unhovered(item: Item):
	hovered_item = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hovered_on_item.connect(_item_hovered)
	hovered_off_item.connect(_item_unhovered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
