extends Control

const SLOTS_IN_ROW = 3

func update() -> void:
	var instantiated_items := GlobalUI.inventory.inventory_items
	var items: Array[InventoryItem] = []
	var item_index := instantiated_items.find_custom(
				func(_item: InventoryItem) -> bool: 
					return _item.num > 0
	)
	items.sort_custom(func(a: InventoryItem, b: InventoryItem) -> bool: return a.DISPLAY_NAME > b.DISPLAY_NAME)
	while item_index != -1:
		items.append(instantiated_items[item_index])
		item_index = instantiated_items.find_custom(
				func(_item: InventoryItem) -> bool: 
					return _item.num > 0
		)
	
	draw_slots(len(items))
	
	instantiated_items


func draw_slots(slot_num: int):
	var row_num: int = ceil(slot_num / SLOTS_IN_ROW)
	
	for row_index in range(row_num):
		var row_node := VBoxContainer.new()
		row_node.name = "InventoryRow" + str(row_index)
		print(row_node.name)
		
		for col_index in range(min(slot_num, SLOTS_IN_ROW)):
			var col_node := HBoxContainer.new()
			col_node.name = "InventoryColumn" + str(col_index)
			
			# Add slot to each InventoryColumn
			
			
			row_node.add_child(col_node)
			slot_num -= 1
		add_child(row_node)
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_slots(28)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
