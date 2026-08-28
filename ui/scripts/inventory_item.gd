class_name InventoryItem
extends Resource

static var instantiated_items: Array[String] = []
@export var DISPLAY_NAME: String
@export var ITEM_TEXTURE: Texture2D
@export var ITEM_OBJECT: PackedScene

var num: int

func _init(display_name: String = "", item_object: PackedScene = null, _num: int = 0):
	self.DISPLAY_NAME = display_name
	self.ITEM_OBJECT = item_object
	self.num = _num

func add(add_num: int = 1):
	self.num += add_num

func spawn(pos: Vector2) -> Item:
	if num > 0:
		num -= 1
		var node: Item = ITEM_OBJECT.instantiate()
		node.position = pos
		return node
	else:
		push_error("Number of ", DISPLAY_NAME, " is <= 0")
		return null
	
static func is_instantiated(name: String) -> bool:
	return name in instantiated_items

func _to_string() -> String:
	return str(num) + " " + DISPLAY_NAME
