class_name Inventory
extends Resource

@export var ITEMS_PATH := "res://ui/inventory/items/"
var inventory_items: Array[InventoryItem]

func _init() -> void:
	for file_name in DirAccess.get_files_at(ITEMS_PATH):
		var item: InventoryItem = load(ITEMS_PATH.path_join(file_name))
		item.num = item.START_COUNT
		var display_name := item.DISPLAY_NAME
		
		# Throws debug error if display name already exists
		assert(display_name not in InventoryItem.instantiated_items, "Item already exists!")
		InventoryItem.instantiated_items.append(display_name)
		
		inventory_items.append(item)

signal update_inventory()

func add_node(item: Node2D):
	var display_name = item.DISPLAY_NAME
	var inventory_item := get_item(display_name)
	if inventory_item:
		inventory_item.add()
	else:
		inventory_item = InventoryItem.new(display_name, load(item.scene_file_path), 1)
		inventory_items.append(inventory_item)
		push_warning("Unregistered item ", inventory_item.DISPLAY_NAME, " added to inventory - will not have a texture!")
	update_inventory.emit()

func get_item(display_name: String) -> InventoryItem:
	if InventoryItem.is_instantiated(display_name):
		var item_index := inventory_items.find_custom(
			func(_item: InventoryItem) -> bool: 
				return _item.DISPLAY_NAME == display_name
		)
		return inventory_items[item_index]
	else:
		return null
