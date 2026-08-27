extends RigidBody2D

const X_THROW_STRENGTH: float = 0.8
const Y_THROW_STRENGTH: float = 0.4

var mouse_on: bool = false
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var last_mouse_position: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		drag_offset = global_position - get_global_mouse_position()
		dragging = true

	if dragging and Input.is_action_pressed("left_click"):
		last_mouse_position = get_global_mouse_position()
		freeze = true
		set_global_position(get_global_mouse_position() + drag_offset)

	elif dragging:
		freeze = false
		dragging = false
	
		var unscaled_velocity = (get_global_mouse_position() - last_mouse_position) / delta
	
		linear_velocity = Vector2(X_THROW_STRENGTH * unscaled_velocity.x, Y_THROW_STRENGTH * unscaled_velocity.y)

func _on_select_box_mouse_entered() -> void:
	mouse_on = true

func _on_select_box_mouse_exited() -> void:
	mouse_on = false
