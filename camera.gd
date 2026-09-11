extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalUI.camera = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func move(pos: Vector2) -> void:
	position = pos
