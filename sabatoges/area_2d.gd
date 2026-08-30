class_name Fire_Area
extends Area2D

signal Entered_Area(node: Node2D, status: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_area_entered(area: Area2D) -> void:
	if area is extinguisher_smoke:
		emit_signal("Entered_Area",get_parent(), "inside")


func _on_area_exited(area: Area2D) -> void:
	if area is extinguisher_smoke:
		emit_signal("Entered_Area",get_parent(), "outside")
