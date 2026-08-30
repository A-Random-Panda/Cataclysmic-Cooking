extends Node

var vistor_time: float = 0.0
var vistor_here: bool = false
var fire_list: Array[Vector2] = []
var timer: float = 0.0
var fire_sabo: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fire_sabo:
		Hyvariables.timer += delta
	if not vistor_here:
		Hyvariables.vistor_time += delta
