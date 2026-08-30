extends Control

@onready var INGREDIENT_STAT_NODE = $RightPanel/VBoxContainer/IngredientStats
@onready var TEXTURE_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer/Texture
@onready var NAME_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer/Name
@onready var INGREDIENT_SLOTS_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer2/IngredientSlots

@onready var FLAVORS_CONTAINER_NODE = $RightPanel/VBoxContainer/Background/VBoxContainer/Flavors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 0.0)
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

func item_hovered(physics_item: Item) -> void:
	var display_name := physics_item.DISPLAY_NAME
	var item := GlobalUI.inventory.get_item(display_name)
	TEXTURE_NODE.texture = item.ITEM_TEXTURE
	NAME_NODE.text = "[center]" + display_name + "[/center]"
	# Old IngredientSlots display
	INGREDIENT_SLOTS_NODE.text = "[center]" + "NaN" + "[/center]"
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func item_unhovered(item: Item) -> void:
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 0.0)
