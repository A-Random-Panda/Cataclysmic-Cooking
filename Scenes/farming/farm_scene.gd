extends Node2D
var worker_num = 0
@export var worker_scenes : PackedScene 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Hyvariables.workers > worker_num:
		var worker = worker_scenes.instantiate()
		worker.position = Vector2(500+randi_range(0,50),300-randi_range(0,50))
		add_child(worker)
		worker_num += 1
		


func _on_button_button_down() -> void:
	Hyvariables.workers += 1
	
