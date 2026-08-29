extends Node2D
var GROWTH_TIME = 1

var growth = 0
var scale_init = []
var crops = []
@export var growing_crop : PackedScene 
var harvestable : bool = false
var offset = Vector2.ZERO
var ingredient : Item
var sprite
var selectbox
var hitbox 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	ingredient = find_child("*Ingredient") 
	ingredient.freeze = true
	sprite = find_child("*Sprite")
	selectbox = find_child("*SelectBox")
	hitbox = find_child("Hitbox")
	scale_init = [find_child("*Sprite").scale.x,find_child("*SelectBox").scale.x,find_child("*Hitbox").scale.x]
	offset = ingredient.position
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if growth < 1:
		growth += delta/GROWTH_TIME
		sprite.scale.x = scale_init[0] * growth
		sprite.scale.y = scale_init[0] * growth
		selectbox.scale = Vector2.ZERO
		hitbox.scale = Vector2.ZERO
		ingredient.position = offset * growth
		ingredient.freeze = true
	else:
		
		selectbox.scale.x = scale_init[1]
		selectbox.scale.y = scale_init[1] 
		hitbox.scale.x = scale_init[2]
		hitbox.scale.y = scale_init[2]
		
		crops.append(growing_crop.instantiate())
		for crop in crops:
			crop.position = offset
	
			add_child(crop)
		crops = []
		growth = 0


	
