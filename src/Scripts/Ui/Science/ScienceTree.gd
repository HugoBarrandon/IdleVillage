extends Control

class_name ScienceTree

@export var skills : Control

var can_move_camera : bool = false
var last_position : Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 3:
		can_move_camera = event.pressed
		last_position = event.position
	elif event is InputEventMouseMotion and can_move_camera:
		var new_pos : Vector2 = get_viewport().get_mouse_position()
		skills.position -= (last_position - new_pos)/scale.x
		last_position = new_pos
