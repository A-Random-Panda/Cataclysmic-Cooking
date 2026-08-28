extends Node

var inventory: Inventory = preload("res://ui/inventory/inventory.tres")

"""
class InventoryItem:
	static var instantiated_items: Array[String] = []
	var num: int
	var display_name: String
	var item_object: PackedScene
	
	func _init(display_name: String, item_object: PackedScene, num: int = 0):
		# Throws debug error if display name already exists
		assert(display_name not in instantiated_items, "Item already exists!")
		
		self.display_name = display_name
		instantiated_items.append(display_name)
		
		self.item_object = item_object
		self.num = num
	
	func add(num: int = 1):
		self.num += num
	
	
	func spawn(x_pos: float, y_pos: float):
		pass
	
	
	
	static func is_instantiated(display_name: String) -> bool:
		return display_name in instantiated_items
	
	func _to_string() -> String:
		return str(num) + " " + display_name


class Inventory:
	var inventory_items: Array[InventoryItem] = []

	func add(item: Node2D):
		var display_name = item.DISPLAY_NAME
		if InventoryItem.is_instantiated(display_name):
			var item_index := inventory_items.find_custom(
				func(item: InventoryItem) -> bool: 
					return item.display_name == display_name
			)
			inventory_items[item_index].add()
		else:
			var inventory_item := InventoryItem.new(display_name, load(item.scene_file_path), 1)
			inventory_items.append(inventory_item)
		
		print(inventory_items)
"""







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
