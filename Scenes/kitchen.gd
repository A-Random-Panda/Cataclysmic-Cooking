extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		get_tree().change_scene_to_file("res://Scenes/farm.tscn") #replace the path with actually path
