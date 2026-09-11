class_name InventoryArea
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision_shape := get_node("Hitbox") as CollisionShape2D
	var rect_shape := collision_shape.shape as RectangleShape2D
	
	var size := rect_shape.size * collision_shape.global_scale
	var top_left_position := collision_shape.global_position - (size / 2.0)
	
	GlobalUI.inventory_rect = Rect2(top_left_position, size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func add_to_inventory(node: Node2D) -> void:
	GlobalUI.inventory.add_node(node)
	node.queue_free()


#func _on_area_entered(area: Area2D) -> void:
	#print("enter")
	#var node: Node2D = area.get_parent()
	#if node is Item:
		#node.in_inventory = true
#
#func _on_area_exited(area: Area2D) -> void:
	#print("enter")
	#var node: Node2D = area.get_parent()
	#if node is Item:
		#node.in_inventory = false
