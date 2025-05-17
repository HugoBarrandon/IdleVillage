extends Node2D

@export var m_tilemap : TileMapLayer
@export var m_tileset : TileSet
@export var m_item : PackedScene

#Placement
var is_placing : bool = false
var orientation : TileTransform = TileTransform.ROTATE_0
var last_pos : Vector2i = Vector2i.ZERO

enum TileTransform {
	ROTATE_0 = 0,
	ROTATE_90 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	ROTATE_180 = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	ROTATE_270 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V,
}

func _input(event: InputEvent) -> void:	
	if event is InputEventMouseButton:
		if event.button_index == 1:
			is_placing = event.pressed
			last_pos = m_tilemap.local_to_map(get_global_mouse_position())
			try_place_tile()
		if event.button_index == 2:
			var item : Node2D = m_item.instantiate()
			item.position = tilemap_centerer(get_global_mouse_position())
			get_parent().add_child(item)
			
	elif event is InputEventMouseMotion:
		try_place_tile()

func try_place_tile() -> void:
	if is_placing:
		var tile_pos = m_tilemap.local_to_map(get_global_mouse_position())
		check_rotation(tile_pos)
		m_tilemap.set_cell(tile_pos,0,Vector2i.ZERO, orientation)
		last_pos = tile_pos

func check_rotation(cell_pos : Vector2i) -> void:
	var delta : Vector2i = cell_pos - last_pos
	var old_orientation : TileTransform = orientation
	match delta:
		Vector2i.UP : orientation = TileTransform.ROTATE_0
		Vector2i.RIGHT : orientation = TileTransform.ROTATE_90
		Vector2i.DOWN : orientation = TileTransform.ROTATE_180
		Vector2i.LEFT : orientation = TileTransform.ROTATE_270
	if old_orientation != orientation:
		m_tilemap.set_cell(last_pos,0,Vector2i.ZERO, orientation)

func tilemap_centerer(world_pos : Vector2) -> Vector2:
	return  m_tilemap.map_to_local(m_tilemap.local_to_map(world_pos))
