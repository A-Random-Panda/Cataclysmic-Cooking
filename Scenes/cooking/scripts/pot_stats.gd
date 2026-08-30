extends Control

@onready var INGREDIENT_STAT_NODE = $RightPanel/VBoxContainer/Background2/IngredientStats
@onready var TEXTURE_NODE = $RightPanel/VBoxContainer/Background2/IngredientStats/HBoxContainer/VBoxContainer/Texture
@onready var NAME_NODE = $RightPanel/VBoxContainer/Background2/IngredientStats/HBoxContainer/VBoxContainer/Name
@onready var INGREDIENT_SLOTS_NODE = $RightPanel/VBoxContainer/Background2/IngredientStats/HBoxContainer/VBoxContainer2/IngredientSlots
@onready var INGREDIENT_SLOTS_BACKGROUND = $RightPanel/VBoxContainer/Background2

@onready var FLAVORS_CONTAINER_NODE = $RightPanel/VBoxContainer/Background/VBoxContainer/Flavors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INGREDIENT_SLOTS_BACKGROUND.modulate = Color(1.0, 1.0, 1.0, 0.0)
	
	for flavor_container in FLAVORS_CONTAINER_NODE.get_children():
		flavor_container.get_child(1).get_child(0).modulate = Color(1.0, 1.0, 1.0, 0.0)
	
	GlobalUI.hovered_on_item.connect(item_hovered)
	GlobalUI.hovered_off_item.connect(item_unhovered)
	
	# Connect display_flavor from pot
	GlobalUI.display_flavor.connect(display_flavor)


func display_flavor(flavor_dict: Dictionary) -> void:
	for flavor_container in FLAVORS_CONTAINER_NODE.get_children():
		var flavor_name: String = flavor_container.get_child(0).text
		flavor_name = flavor_name.replace("[center]", "")
		flavor_name = flavor_name.replace("[/center]", "")
		flavor_container.get_child(1).value = flavor_dict[flavor_name]

func show_progress() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	
	for flavor_container in FLAVORS_CONTAINER_NODE.get_children():
		var bar: ProgressBar = flavor_container.get_child(1).get_child(0)
		
		# Sets progress bar to opaque
		bar.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
		# Animate bar to transparent over 5 secs
		tween.tween_property(bar, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)


func item_hovered(physics_item: Item) -> void:
	var display_name := physics_item.DISPLAY_NAME
	var item := GlobalUI.inventory.get_item(display_name)
	TEXTURE_NODE.texture = item.ITEM_TEXTURE
	NAME_NODE.text = "[center]" + display_name + "[/center]"
	# Old IngredientSlots display
	INGREDIENT_SLOTS_NODE.text = "[center]" + "NaN" + "[/center]"
	INGREDIENT_SLOTS_BACKGROUND.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func item_unhovered(item: Item) -> void:
	INGREDIENT_SLOTS_BACKGROUND.modulate = Color(1.0, 1.0, 1.0, 0.0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("t_key"):
		show_progress()
