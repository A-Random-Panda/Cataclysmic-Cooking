extends StaticBody2D

@export var ITEMS_PATH := "res://ui/inventory/items/"
var ingredients: Dictionary[String, Ingredient]

class Ingredient:
	var display_name: String
	var count: int
	var flavour: Array[int]
	
	func _init(item: Item) -> void:
		self.display_name = item.DISPLAY_NAME
		self.count = 1
	
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


func calculate_flavor():
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
