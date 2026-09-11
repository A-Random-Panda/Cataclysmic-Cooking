class_name Item
extends RigidBody2D

@export var DISPLAY_NAME := "Item"

@export var X_THROW_STRENGTH: float = 1
@export var Y_THROW_STRENGTH: float = 1
@export var MAX_VELOCITY: float = 10000

@export var CLAMP_CIRCLE_SHAVE := 0.8
@export var RESPAWN_POS := Vector2(200, 200)

const SINGLE_PICKUP := true

@onready var SCREEN_SIZE := get_viewport_rect().size
const PADDING := 100

var in_inventory := false

var mouse_on := false
var dragging := false
var drag_offset := Vector2.ZERO
var last_mouse_position := Vector2.ZERO

var CLAMP_VECTOR := Vector2.ZERO

var mouse_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Calculate the clamping radius
	var clamp_radius: float = 0
	for vector: Vector2 in $Hitbox.polygon:
		clamp_radius = max(clamp_radius, vector.distance_to(Vector2.ZERO)) * CLAMP_CIRCLE_SHAVE
	CLAMP_VECTOR = Vector2(clamp_radius, clamp_radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var vector_zero: Vector2 = GlobalUI.get_vector_zero()
	var vector_max: Vector2 = vector_zero + get_viewport_rect().size
	mouse_pos = vector_zero + get_global_mouse_position()

	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		# Single drag logic
		if SINGLE_PICKUP:
			if !GlobalUI.is_dragging:
				drag_offset = global_position - mouse_pos
				dragging = true
				GlobalUI.is_dragging = true

				# Cooking UI
				if GlobalUI.hovered_item != self:
					GlobalUI.hovered_on_item.emit(self)
		else:
			drag_offset = global_position - mouse_pos
			dragging = true

			# Cooking UI
			if GlobalUI.hovered_item != self:
				GlobalUI.hovered_on_item.emit(self)

	if dragging and Input.is_action_pressed("left_click"):
		last_mouse_position = mouse_pos
		freeze = true

		# Position clamping
		var target_position: Vector2 = mouse_pos + drag_offset
		target_position = target_position.clamp(vector_zero + CLAMP_VECTOR, vector_max - CLAMP_VECTOR)
		set_global_position(target_position)

	elif dragging:
		freeze = false
		dragging = false
		
		# Single drag
		GlobalUI.is_dragging = false
		
		# Cooking UI
		GlobalUI.hovered_off_item.emit(self)
		
		# Detect if mouse released in inventory area
		if GlobalUI.inventory_rect.has_point(get_viewport().get_mouse_position()):
			GlobalUI.inventory.add_node(self)
			queue_free()
		
		# Apply velocity
		var unscaled_velocity := (mouse_pos - last_mouse_position) / delta
		var scaled_velocity := Vector2(X_THROW_STRENGTH * unscaled_velocity.x, Y_THROW_STRENGTH * unscaled_velocity.y)
		linear_velocity = scaled_velocity.limit_length(MAX_VELOCITY)


func _on_select_box_mouse_entered() -> void:
	mouse_on = true
	if !GlobalUI.is_dragging and GlobalUI.hovered_item != self:
		GlobalUI.hovered_on_item.emit(self)

func _on_select_box_mouse_exited() -> void:
	mouse_on = false
	if !dragging and GlobalUI.hovered_item == self:
		GlobalUI.hovered_off_item.emit(self)
