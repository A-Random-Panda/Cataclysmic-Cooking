class_name InventorySlot
extends Panel

@onready var BACKGROUND = get_node("Background")
@onready var TEXTURE = get_node("Texture")
@onready var COUNT = get_node("Count")

var ITEM: InventoryItem

var mouse_on := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_properties(item: InventoryItem) -> void:
	name = item.DISPLAY_NAME
	TEXTURE.texture = item.ITEM_TEXTURE
	COUNT.text = str(item.num)
	ITEM = item


func _on_mouse_entered() -> void:
	mouse_on = true
	self.modulate = Color(1.0, 1.0, 1.0, 0.5)


func _on_mouse_exited() -> void:
	mouse_on = false
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
