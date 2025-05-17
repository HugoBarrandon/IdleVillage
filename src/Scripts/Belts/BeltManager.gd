class_name BeltManager

var belts : Dictionary[Vector2i, BuildManager.TileTransform] = {}

func add_belt(cell_pos : Vector2i, orientation : BuildManager.TileTransform) -> void:
	belts[cell_pos] = orientation
