extends Camera2D

@export var zoom_speed : float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("scroll_up"):
		zoom += Vector2(zoom_speed, zoom_speed)
	if event.is_action("scroll_down"):
		zoom -= Vector2(zoom_speed, zoom_speed)
