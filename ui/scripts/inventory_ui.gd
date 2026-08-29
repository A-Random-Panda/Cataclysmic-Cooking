extends Control

const SLOTS_IN_ROW = 3
var SLOT: PackedScene = load("res://ui/inventory/inventory_slot.tscn")
@onready var SLOT_CONTAINER: GridContainer = $RightPanel/MarginContainer/ScrollContainer/GridContainer

func update() -> void:
	var instantiated_items := GlobalUI.inventory.inventory_items
	var items: Array[InventoryItem] = []
	
	# Filter only InventoryItems with a count > 0
	items.assign(instantiated_items.filter(
		func(_item: InventoryItem) -> bool: 
			return _item.num > 0
	))
	
	# Sort items by alphabetical order
	items.sort_custom(
		func(a: InventoryItem, b: InventoryItem) -> bool: 
			return a.DISPLAY_NAME > b.DISPLAY_NAME
	)
	
	for item in items:
		var new_slot: Panel = SLOT.instantiate()
		SLOT_CONTAINER.add_child(new_slot)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
