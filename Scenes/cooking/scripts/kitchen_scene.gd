extends Control

var mouse_on := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	mouse_on = true


func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
