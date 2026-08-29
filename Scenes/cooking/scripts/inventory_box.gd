class_name 初音ミク
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D):
	if body is Item:
		body.in_inventory = true
		
		if !body.hidden_from_inventory:
			GlobalUI.inventory.add_node(body)
			body.queue_free()

func _on_body_exited(body: Node2D) -> void:
	if body is Item:
		body.in_inventory = false

func _on_button_pressed() -> void:
	var node: Item = GlobalUI.inventory.inventory_items[0].spawn(get_global_mouse_position())
	add_sibling(node)
	# node.hidden_from_inventory = true
