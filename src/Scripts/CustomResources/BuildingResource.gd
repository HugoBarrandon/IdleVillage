@tool
extends Resource

class_name BuildingResource

@export var name : String

@export var resources : Array[Dictionary] = []
@export var textures : Array[Texture2D] = [] :
	set(value):
		textures = value
		if value != null:
			update_size()

@export var size : Vector2i

func update_size() -> void :
	for t in textures:
		var s : Vector2i = t.get_size() / 16
		if s.x > size.x:
			size.x = s.x
		if s.y > size.y:
			size.y = s.y
