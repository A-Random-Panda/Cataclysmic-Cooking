extends Control

var vistor_time: float = 0.0
var vistor_here: bool = false
func enable_ui(state: bool) -> void:
	$yes.disabled = not state
	$yes.visible = state
	$no.disabled = not state
	$no.visible = state
	$"accept?".visible = state
	$TextureButton.visible = state
	$TextureButton.disabled = not state
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Hyvariables.vistor_here:
		enable_ui(false)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = "Timer " + str(int(Hyvariables.game_time))
	
	
	if Input.is_action_just_pressed("ui_right"):
		get_tree().change_scene_to_file("res://Scenes/farming/farm_scene.tscn")






	if Hyvariables.vistor_time > 10 and Hyvariables.vistor_here == false:
		Hyvariables.vistor_here = true
		$TextureButton.visible = true
		$TextureButton.disabled = false
		Hyvariables.vistor_time = 0
	
	if not Hyvariables.fire_sabo:
		$Vent.disabled = true
		$ExclamtionMark.visible = false
	elif Hyvariables.fire_sabo:
		$Vent.disabled = false
		
		$ExclamtionMark.visible = true

func _on_character_button_pressed() -> void:
	enable_ui(true)
	print("character clicked")

func _on_yes_pressed() -> void:
	enable_ui(false)
	print("accepted")
	Hyvariables.workers += 1
	Hyvariables.vistor_here = false

func _on_no_3_pressed() -> void:
	enable_ui(false)
	print("denyed")
	Hyvariables.vistor_here = false


func _on_vent_pressed() -> void:
	get_tree().change_scene_to_file("res://sabatoges/fire_sabotage.tscn")
