extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Hyvariables.x = false
	Hyvariables.timer_running = true
	GlobalUI.vents_scene()


func _on_escape_pressed() -> void:
	get_tree().quit()
	
