class_name InventoryArea
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func add_to_inventory(node: Node2D) -> void:
	GlobalUI.inventory.add_node(node)
	node.queue_free()


func _on_area_entered(area: Area2D) -> void:
	var node: Node2D = area.get_parent()
	if node is Item:
		node.in_inventory = true

func _on_area_exited(area: Area2D) -> void:
	var node: Node2D = area.get_parent()
	if node is Item:
		node.in_inventory = false


func _on_button_pressed() -> void:
	var node: Item = GlobalUI.inventory.inventory_items[0].spawn(get_global_mouse_position())
	add_sibling(node)
	# node.hidden_from_inventory = true
