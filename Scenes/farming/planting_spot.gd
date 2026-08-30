extends Node2D
var obj_inside = false
var obj
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if obj_inside:
		obj.position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	obj_inside = true
	obj = body
func _on_area_2d_body_exited(body: Node2D) -> void:
	obj_inside = false
