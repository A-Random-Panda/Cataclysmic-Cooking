extends Node2D
@export var HARVEST_TIME : int = 10
var children 
var harvest_timer = HARVEST_TIME
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if harvest_time(delta):
		harvest()
	
func harvest():
	children = get_parent().find_children("*GrownCrop")
	print(children)
	'''
	if len(children) >0:
		var harvested_crop = children[randi_range(0,len(children))-1]
		harvested_crop.freeze = false
		print(harvested_crop)
	else:
		print(children)
	'''
func harvest_time(delta):
	if harvest_timer <= 0:
		harvest_timer = HARVEST_TIME
		return true
	else:
		harvest_timer -= delta
		return false
	
	
	
	
