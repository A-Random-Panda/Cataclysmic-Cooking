extends Node2D
var GROWTH_TIME
var growth = 0
var scale_init = []
var crops = []
var init_pos
@export var growing_crop : PackedScene 
var harvestable : bool = false
var offset = Vector2.ZERO
var ingredient : Item
var sprite
var selectbox
var hitbox 
var crop
var grown = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crop = growing_crop.instantiate()
	GROWTH_TIME = find_parent("*Crop").growth_time
	ingredient = find_child("*Item") 
	ingredient.freeze = true
	init_pos = position
	sprite = find_child("*Sprite")
	selectbox = find_child("*SelectBox")
	hitbox = find_child("Hitbox")
	scale_init = [find_child("*Sprite").scale.x,find_child("*SelectBox").scale.x,find_child("*Hitbox").scale.x]
	offset = ingredient.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	grow(delta)
func grow(delta):
	if growth < 1:
		growth += delta/GROWTH_TIME
		sprite.scale.x = scale_init[0] * growth
		sprite.scale.y = scale_init[0] * growth
		selectbox.scale = Vector2.ZERO
		hitbox.scale = Vector2.ZERO
		ingredient.position = offset * growth
		ingredient.freeze = true
		
	elif growth >= 1:
		if grown != true:
			crop = growing_crop.instantiate()
			crop.position = offset
			crop.rotation = ingredient.rotation
			crop.freeze = true
			crop.name = "GrownCrop"
			add_child(crop)
			grown = true
		if is_harvested(crop):
			growth = 0
			grown = false
			crop.reparent(get_parent().get_parent())
		
		
	
func is_harvested(crop) -> bool:
	if crop.freeze == false or crop.dragging:
		return true
	else: 
		return false
		
	
