extends Sprite2D
# dragging logic modified from https://gist.github.com/angstyloop/08200c6d816347c82ea1aed56c219f17

var status = "none"

var texture_size = Vector2()
var mouse_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_size = texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if status == "dragging":
		global_position = mouse_pos + offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if status != "dragging" and event.is_pressed():
			var event_pos = event.global_position
			var global_pos = global_position
			
			var rect = Rect2(global_position.x, global_position.y, texture_size.x, texture_size.y)
			
			if rect.has_point(event_pos):
				status = "clicked"
				offset = global_position - event_pos
			
		elif (status == "dragging" or status == "clicked") and not event.is_pressed():
			status = "released"
	
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		if status == "clicked":
			status = "dragging"

func _draw() -> void:
	draw_rect(Rect2(global_position.x, global_position.y, texture_size.x, texture_size.y), "Red")
