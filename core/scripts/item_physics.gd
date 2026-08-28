class_name Item
extends RigidBody2D

@export var DISPLAY_NAME: String = "Item"

@export var X_THROW_STRENGTH: float = 1
@export var Y_THROW_STRENGTH: float = 1

@export var CLAMP_CIRCLE_SHAVE: float = 0.8

var mouse_on: bool = false
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var last_mouse_position: Vector2 = Vector2.ZERO

var clamp_vector: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Calculate the clamping radius
	var clamp_radius: float = 0
	for vector: Vector2 in $Hitbox.polygon:
		clamp_radius = max(clamp_radius, vector.distance_to(Vector2.ZERO)) * CLAMP_CIRCLE_SHAVE
	clamp_vector = Vector2(clamp_radius, clamp_radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		drag_offset = global_position - get_global_mouse_position()
		dragging = true

	if dragging and Input.is_action_pressed("left_click"):
		last_mouse_position = get_global_mouse_position()
		freeze = true
		
		# Position clamping
		var target_position: Vector2 = get_global_mouse_position() + drag_offset
		target_position = target_position.clamp(Vector2.ZERO + clamp_vector, get_viewport_rect().size - clamp_vector)
		set_global_position(target_position)

	elif dragging:
		freeze = false
		dragging = false
	
		var unscaled_velocity = (get_global_mouse_position() - last_mouse_position) / delta
	
		linear_velocity = Vector2(X_THROW_STRENGTH * unscaled_velocity.x, Y_THROW_STRENGTH * unscaled_velocity.y)

func _on_select_box_mouse_entered() -> void:
	mouse_on = true

func _on_select_box_mouse_exited() -> void:
	mouse_on = false
