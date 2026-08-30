extends Node2D

var cur_fire: Node2D
var smoke_timer: float = 0.0
@export var point_1: Vector2 = Vector2(100,100)
@export var point_2: Vector2 = Vector2 (1050, 550)
@onready var fire_png: PackedScene = preload("res://sabatoges/fire.tscn")
var smoke_inside: bool = false
@onready var audio = $AudioStreamPlayer2D

func gen_rand_point(p1: Vector2, p2: Vector2) -> Vector2:
	var x_val: float = randf_range(p1.x, p2.x)
	var y_val: float = randf_range(p1.y, p2.y)
	var rand_point: Vector2 = Vector2(x_val,y_val)
	return rand_point

func spawn_fire():
	var fire_instance: Node2D = fire_png.instantiate()
	add_child(fire_instance)
	var spawn_location: Vector2 = gen_rand_point(point_1,point_2)
	fire_instance.set_position(spawn_location)
	Hyvariables.fire_list.append(fire_instance.position)
	var fire_area: Fire_Area = fire_instance.get_node("Area2D")
	fire_area.Entered_Area.connect(_on_fire_area_changed)
	
func spawn_fire_at(position: Vector2):
	var fire_instance: Node2D = fire_png.instantiate()
	add_child(fire_instance)
	fire_instance.position = position
	var fire_area: Fire_Area = fire_instance.get_node("Area2D")
	fire_area.Entered_Area.connect(_on_fire_area_changed)
	
func _on_fire_area_changed(fire: Node2D, status: String) -> void:
	if status == "inside":
		smoke_inside = true
		cur_fire = fire
	elif status == "outside":
		smoke_inside = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for pos in Hyvariables.fire_list:
		spawn_fire_at(pos)

	for i in range(5 + Hyvariables.insta_fire):
		spawn_fire()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	Hyvariables.in_sabo = true
	if Hyvariables.fire_sabo:
		if Hyvariables.timer > 6 and len(Hyvariables.fire_list) > 0 and len(Hyvariables.fire_list) < 40:
			spawn_fire()
			Hyvariables.timer = 0
			
	if len(Hyvariables.fire_list) == 0:
		Hyvariables.in_sabo = false
		Hyvariables.insta_fire = 0
		Hyvariables.fire_sabo = false
		Hyvariables.x = false
		Hyvariables.sabotimer = 0
		get_tree().change_scene_to_file("res://Scenes/entrance/entrance.tscn")
		

	if smoke_timer > 1.4:
		cur_fire.queue_free()
		Hyvariables.fire_list.erase(cur_fire.position)
		smoke_timer = 0
	
	if smoke_inside:
		smoke_timer += delta
		if not audio.playing:
			audio.play()
	elif !smoke_inside:
		smoke_timer = 0
		if audio.playing:
			audio.stop()
	
