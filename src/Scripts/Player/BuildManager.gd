extends Node2D

class_name BuildManager

@export var belt_tilemap : TileMapLayer
@export var building_scene : PackedScene
@export var builds_container : Node2D

var belt_manager : BeltManager = BeltManager.new()

#Placement
var is_placing : bool = false
var is_building : bool = false
var orientation : TileTransform = TileTransform.ROTATE_0
var last_pos : Vector2i = Vector2i.ZERO

var current_building : BuildingResource = null

enum TileTransform {
	ROTATE_0 = 0,
	ROTATE_90 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	ROTATE_180 = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	ROTATE_270 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V,
}

func _enter_tree() -> void:
	GameManager.build_manager = self
	current_building = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("build_button"):
		is_building = !is_building
		if not is_building :
			is_placing = false
	elif event is InputEventMouseButton:
		if event.button_index == 1:
			if is_building:
				is_placing = event.pressed
				last_pos = belt_tilemap.local_to_map(get_global_mouse_position())
				try_place_tile()
			elif current_building != null:
				Preview.instance.texture = null
				place_building(get_global_mouse_position())
				current_building = null
	elif event is InputEventMouseMotion:
		try_place_tile()

func item_check(item : Item) -> void:
	item.move_direction = get_movement(belt_tilemap.local_to_map(item.position))

func try_place_tile() -> void:
	if is_placing:
		var tile_pos = belt_tilemap.local_to_map(get_global_mouse_position())
		check_rotation(tile_pos)
		
		belt_tilemap.set_cell(tile_pos,0,Vector2i.ZERO, orientation)
		belt_manager.add_belt(tile_pos, orientation)
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
		belt_tilemap.set_cell(last_pos,0,Vector2i.ZERO, orientation)
		belt_manager.add_belt(last_pos, orientation)

func tilemap_centerer(world_pos : Vector2) -> Vector2:
	return  belt_tilemap.map_to_local(belt_tilemap.local_to_map(world_pos))

func get_movement(cell_pos : Vector2i) -> Vector2i:
	if belt_manager.belts.has(cell_pos):
		var o = belt_manager.belts[cell_pos]
		
		match o:
			TileTransform.ROTATE_0 : return Vector2i.UP
			TileTransform.ROTATE_90 : return Vector2i.RIGHT
			TileTransform.ROTATE_180 : return Vector2i.DOWN
			TileTransform.ROTATE_270 : return Vector2i.LEFT
	return Vector2i.ZERO

func select_building(building : BuildingResource) -> void:
	current_building = building

func place_building(world_pos : Vector2) -> void:
	var b : Building = building_scene.instantiate()
	b.position = world_pos
	World.align_on_grid(b)
	b.building = current_building
	if current_building.name == "House":
		b.on_upgraded.connect(World.instance.spawn_npc.bind(b.position + Vector2.DOWN*16*3))
	builds_container.add_child(b)
