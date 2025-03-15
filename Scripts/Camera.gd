extends Camera2D

@export var zoom_speed : float

var can_move : bool = false
var last_position : Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action("scroll_up"):
		zoom += Vector2(zoom_speed, zoom_speed)
	if event.is_action("scroll_down"):
		zoom -= Vector2(zoom_speed, zoom_speed)
	
	if event is InputEventMouseButton:
		handle_mouse(event)

func handle_mouse(event : InputEventMouseButton):
	if event.button_index == 1:
		can_move = event.pressed
		last_position = event.position

func _process(delta: float) -> void:
	if can_move:
		var new_pos : Vector2 = get_viewport().get_mouse_position()
		position += last_position - new_pos
		last_position = new_pos
