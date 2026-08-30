extends StaticBody2D

@export var ITEMS_PATH := "res://ui/inventory/items/"
var ingredients: Dictionary[String, Ingredient]
var total_flavor: Dictionary[String, int] = {
		"Saltiness": 0, 
		"Sweetness": 0,
		"Sourness": 0,
		"Bitterness": 0,
		"Savoriness": 0
	}

class Ingredient:
	var display_name: String
	var count: int
	var flavor: Dictionary[String, int] = {
		"Saltiness": 0, 
		"Sweetness": 0,
		"Sourness": 0,
		"Bitterness": 0,
		"Savoriness": 0
	}
	
	func _init(item: Item) -> void:
		self.display_name = item.DISPLAY_NAME
		self.count = 1
		
		# Set item flavor
		var inv_item: InventoryItem = GlobalUI.inventory.get_item(display_name)
		self.flavor = inv_item.FLAVOUR.duplicate()
	
	func add() -> void:
		self.count += 1
	
	# Returns bool is_empty
	func remove() -> bool:
		self.count -= 1
		if self.count <= 0:
			return true
		return false
	
	func _to_string() -> String:
		return str(count) + " " + display_name


func calculate_flavor() -> void:
	# Reset and recalculate total_flavor
	total_flavor = {
		"Saltiness": 0, 
		"Sweetness": 0,
		"Sourness": 0,
		"Bitterness": 0,
		"Savoriness": 0
	}
	for ingredient: Ingredient in ingredients.values():
		for flavour_name in ingredient.flavor:
			total_flavor[flavour_name] += ingredient.count * ingredient.flavor[flavour_name]
	GlobalUI.display_flavor.emit(total_flavor)

func cook() -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var item: Node2D = area.get_parent()
	if item is Item:
		var display_name = item.DISPLAY_NAME

		var ingredient: Ingredient = ingredients.get(display_name)
		if ingredient:
			ingredient.add()
		else:
			var new_ingredient := Ingredient.new(item)
			ingredients[display_name] = new_ingredient
		calculate_flavor()

func _on_area_exited(area: Area2D) -> void:
	var item: Node2D = area.get_parent()
	if item is Item:
		var display_name = item.DISPLAY_NAME
		var ingredient: Ingredient = ingredients.get(display_name)
		
		var is_empty: bool = ingredient.remove()
		if is_empty:
			ingredients.erase(display_name)
	
		calculate_flavor()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("c_key"):
		cook()
