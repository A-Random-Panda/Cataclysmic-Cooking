extends Control

const SLOTS_IN_ROW = 3
var SLOT: PackedScene = load("res://ui/inventory/inventory_slot.tscn")
@onready var SLOT_CONTAINER: GridContainer = $RightPanel/VBoxContainer/MarginContainer/ScrollContainer/GridContainer

func update() -> void:
	var instantiated_items := GlobalUI.inventory.inventory_items
	var items: Array[InventoryItem] = []
	
	# Clears all slots in SLOT_CONTAINER
	for slot in SLOT_CONTAINER.get_children():
		slot.queue_free()
	
	# Filter only InventoryItems with a count > 0
	items.assign(instantiated_items.filter(
		func(_item: InventoryItem) -> bool: 
			return _item.num > 0
	))
	
	# Sort items by alphabetical order
	items.sort_custom(
		func(a: InventoryItem, b: InventoryItem) -> bool: 
			return a.DISPLAY_NAME < b.DISPLAY_NAME
	)
	for item in items:
		var new_slot: InventorySlot = SLOT.instantiate()
		SLOT_CONTAINER.add_child(new_slot)
		new_slot.set_properties(item)
		new_slot.gui_input.connect(_on_gui_input.bind(new_slot))
		

# Connected to gui_input signal from Slot
# Additional argument Slot bound to function
func _on_gui_input(event: InputEvent, slot: InventorySlot) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var node: Item = slot.ITEM.spawn(get_global_mouse_position())
		add_sibling(node)
		update()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalUI.inventory.update_inventory.connect(update)
	update()
