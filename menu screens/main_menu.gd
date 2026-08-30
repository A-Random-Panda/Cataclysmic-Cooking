extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/entrance/entrance.tscn")
	Hyvariables.x = false
	Hyvariables.timer_running = true


func _on_escape_pressed() -> void:
	get_tree().quit()
	
