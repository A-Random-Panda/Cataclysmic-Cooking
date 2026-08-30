extends Control

@onready var INGREDIENT_STAT_NODE = $RightPanel/VBoxContainer/IngredientStats
@onready var TEXTURE_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer/Texture
@onready var NAME_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer/Name
@onready var INGREDIENT_SLOTS_NODE = $RightPanel/VBoxContainer/IngredientStats/HBoxContainer/VBoxContainer2/IngredientSlots


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 0.0)
	GlobalUI.hovered_on_item.connect(item_hovered)
	GlobalUI.hovered_off_item.connect(item_unhovered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func item_hovered(physics_item: Item) -> void:
	var display_name := physics_item.DISPLAY_NAME
	var item := GlobalUI.inventory.get_item(display_name)
	TEXTURE_NODE.texture = item.ITEM_TEXTURE
	NAME_NODE.text = "[center]" + display_name + "[/center]"
	INGREDIENT_SLOTS_NODE.text = "[center]" + str(item.INGREDIENT_SLOTS) + "[/center]"
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func item_unhovered(item: Item) -> void:
	INGREDIENT_STAT_NODE.modulate = Color(1.0, 1.0, 1.0, 0.0)
