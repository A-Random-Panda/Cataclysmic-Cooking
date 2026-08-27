extends RigidBody2D
# dragging logic modified from https://www.reddit.com/r/godot/comments/98buso/area2d_drag_and_drop_psysics_collision/

const PULL_SPEED: float = 60
const STIFFNESS: float = 80;
const DAMP_COEFFICIENT: float = 5;

var mouse_on: bool = false
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		drag_offset = global_position - get_global_mouse_position()
		dragging = true
		
	if dragging and Input.is_action_pressed("left_click"):
		# Calculate force
		var target: Vector2 = get_global_mouse_position() + drag_offset
		var direction: Vector2 = (target - global_position).normalized()
		var distance: float = global_position.distance_to(target)
		# constant_force = direction * distance * PULL_SPEED
		
		# Apply proportional-derivative controller (for damping)
		constant_force = (direction * distance * STIFFNESS) - (linear_velocity * DAMP_COEFFICIENT)
		
		
		# print(linear_velocity)
		# set_global_position(get_global_mouse_position() + drag_offset)
	else:
		constant_force = Vector2.ZERO
		dragging = false

func _mouse_enter() -> void:
	mouse_on = true

func _mouse_exit() -> void:
	mouse_on = false
