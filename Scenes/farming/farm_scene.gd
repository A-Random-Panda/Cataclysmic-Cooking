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
	if Input.is_action_just_pressed("ui_left"):	
		get_tree().change_scene_to_file("res://Scenes/entrance/entrance.tscn")
	if Input.is_action_just_pressed("ui_right"):
		get_tree().change_scene_to_file("res://Scenes/cooking/cook_main.tscn")

func _on_texture_button_button_down() -> void:
	Hyvariables.workers += 1
