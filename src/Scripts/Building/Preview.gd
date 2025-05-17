extends Sprite2D

class_name Preview

static var instance : Preview

func _init() -> void:
	instance = self

func _process(_delta: float) -> void:
	var p  = get_global_mouse_position()
	position = World.overworld.map_to_local(World.overworld.local_to_map(p))

func select_building(building : BuildingResource):
	texture = building.textures[0]
