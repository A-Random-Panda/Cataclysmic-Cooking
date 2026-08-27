extends RigidBody2D

var mouse_on: bool = false
var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var last_mouse_velocities: PackedVector2Array = [Vector2.ZERO];


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if !dragging and mouse_on and Input.is_action_pressed("left_click"):
		drag_offset = global_position - get_global_mouse_position()
		dragging = true
		
	if dragging and Input.is_action_pressed("left_click"):
		freeze = true
		set_global_position(get_global_mouse_position() + drag_offset)
	elif dragging:
		freeze = false
		dragging = false
		
		# Weighted average of 5 vectors in last_mouse_velocities and apply linear velocity
		var xSum: float = 0
		var ySum: float = 0
		var weightSum: int = 0
		for i in range(len(last_mouse_velocities)):
			var mouse_velocity: Vector2 = last_mouse_velocities[i]
			var weight = i + 1
			weightSum += weight
			xSum += weight * mouse_velocity.x
			ySum += weight * mouse_velocity.y
		xSum /= weightSum
		ySum /= weightSum
		print(Vector2(xSum, ySum))
		linear_velocity = Vector2(xSum, ySum)
		
		print(last_mouse_velocities)
		# Remember to reset the stale data!
		last_mouse_velocities = [Vector2.ZERO]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and dragging:
		last_mouse_velocities.append(event.velocity)
		if len(last_mouse_velocities) > 3:
			last_mouse_velocities.remove_at(0)

func _mouse_enter() -> void:
	mouse_on = true

func _mouse_exit() -> void:
	mouse_on = false
