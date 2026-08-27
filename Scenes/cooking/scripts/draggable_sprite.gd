extends Area2D
# dragging logic modified from https://www.reddit.com/r/godot/comments/98buso/area2d_drag_and_drop_psysics_collision/

var mouse_on: bool = false
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		drag_offset = global_position - get_global_mouse_position()
		dragging = true
		
	if dragging and Input.is_action_pressed("left_click"):
		set_global_position(get_global_mouse_position() + drag_offset)
	else:
		dragging = false

func _mouse_enter() -> void:
	mouse_on = true

func _mouse_exit() -> void:
	mouse_on = false
