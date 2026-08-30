extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		get_tree().change_scene_to_file("res://sabatoges/fire_sabotage.tscn") #replace the path with actually path
	if Input.is_action_just_pressed("ui_right"):
		#get_tree().change_scene_to_file("res://Scenes/kitchen.tscn") #replace the path with actually path
		print("idk")
