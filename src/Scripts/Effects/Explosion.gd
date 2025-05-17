extends Node2D

@onready var animator : AnimationPlayer = $AnimationPlayer

func on_animation_end() -> void :
	queue_free()
