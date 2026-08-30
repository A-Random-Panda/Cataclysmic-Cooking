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
const PADDING := 200

var in_inventory := false

var mouse_on := false
var dragging := false
var drag_offset := Vector2.ZERO
var last_mouse_position := Vector2.ZERO

var CLAMP_VECTOR := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Calculate the clamping radius
	var clamp_radius: float = 0
	for vector: Vector2 in $Hitbox.polygon:
		clamp_radius = max(clamp_radius, vector.distance_to(Vector2.ZERO)) * CLAMP_CIRCLE_SHAVE
	CLAMP_VECTOR = Vector2(clamp_radius, clamp_radius)
	
	# Check if item is in the backrooms every 2 seconds
	var timer := Timer.new()
	timer.wait_time = 2
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_check_respawn)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		# Single drag logic
		if SINGLE_PICKUP:
			if !GlobalUI.is_dragging:
				drag_offset = global_position - get_global_mouse_position()
				dragging = true
				GlobalUI.is_dragging = true
				
				# Cooking UI
				if GlobalUI.hovered_item != self:
					GlobalUI.hovered_on_item.emit(self)
		else:
			drag_offset = global_position - get_global_mouse_position()
			dragging = true
			
			# Cooking UI
			if GlobalUI.hovered_item != self:
				GlobalUI.hovered_on_item.emit(self)

	if dragging and Input.is_action_pressed("left_click"):
		last_mouse_position = get_global_mouse_position()
		freeze = true
		
		# Position clamping
		var target_position: Vector2 = get_global_mouse_position() + drag_offset
		target_position = target_position.clamp(Vector2.ZERO + CLAMP_VECTOR, get_viewport_rect().size - CLAMP_VECTOR)
		set_global_position(target_position)

	elif dragging:
		freeze = false
		dragging = false
		
		# Single drag
		GlobalUI.is_dragging = false
		
		# Cooking UI
		GlobalUI.hovered_off_item.emit(self)
		
		if in_inventory:
			InventoryArea.add_to_inventory(self)
		
		# Apply velocity
		var unscaled_velocity := (get_global_mouse_position() - last_mouse_position) / delta
		var scaled_velocity := Vector2(X_THROW_STRENGTH * unscaled_velocity.x, Y_THROW_STRENGTH * unscaled_velocity.y)
		linear_velocity = scaled_velocity.limit_length(MAX_VELOCITY)


# Check if item is in the backrooms
func _check_respawn() -> void:
	if position.x < -PADDING or position.x > SCREEN_SIZE.x + PADDING or position.y < -PADDING or position.y > SCREEN_SIZE.y + PADDING:
		freeze = true
		position = RESPAWN_POS
		freeze = false


func _on_select_box_mouse_entered() -> void:
	mouse_on = true
	if !GlobalUI.is_dragging and GlobalUI.hovered_item != self:
		GlobalUI.hovered_on_item.emit(self)

func _on_select_box_mouse_exited() -> void:
	mouse_on = false
	if !dragging and GlobalUI.hovered_item == self:
		GlobalUI.hovered_off_item.emit(self)
