extends Control

var mouse_on := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PotScene.hide()
	$PotStats.hide()
	$PotScene/Pot/Hitbox.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		get_tree().change_scene_to_file("res://Scenes/farming/farm_scene.tscn")



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouse_on:
			$PotScene.show()
			$PotStats.show()
			$PotScene/Pot/Hitbox.set_deferred("disabled", false)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			$PotScene.hide()
			$PotStats.hide()
			$PotScene/Pot/Hitbox.set_deferred("disabled", true)


func _on_area_2d_mouse_entered() -> void:
	mouse_on = true


func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
