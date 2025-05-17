extends Camera2D

class_name PlayerCamera

@export var zoom_speed : float

var can_move_camera : bool = false
var last_position : Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action("scroll_up"):
		zoom += Vector2(zoom_speed, zoom_speed)
	if event.is_action("scroll_down") && zoom.x > 1:
		zoom -= Vector2(zoom_speed, zoom_speed)
		
	if event is InputEventMouseButton and event.button_index == 3:
		can_move_camera = event.pressed
		last_position = event.position
	elif event is InputEventMouseMotion and can_move_camera:
		var new_pos : Vector2 = get_viewport().get_mouse_position()
		position += (last_position - new_pos)/zoom.x
		last_position = new_pos
