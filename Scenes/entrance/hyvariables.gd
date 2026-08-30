extends Node

var vistor_time: float = 0.0
var vistor_here: bool = false
var fire_list: Array[Vector2] = []
var timer: float = 0.0
var fire_sabo: bool = true
var in_sabo: bool = false
var timer2: float = 0.0
var insta_fire: int = 0
var workers: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fire_sabo:
		timer += delta
	if not in_sabo:
		timer2 += delta
		if timer2 > 8:
			insta_fire += 1
			timer2 = 0
			
			
		
	
	if not vistor_here:
		Hyvariables.vistor_time += delta
