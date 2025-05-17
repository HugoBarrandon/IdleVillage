extends Node2D
class_name Building

@export_group("Nodes")
@export var fence_layer : TileMapLayer
@export var sprite : Sprite2D
@export var ui : BuildUi
@export var audio : AudioStreamPlayer
@export var explosion_effect : PackedScene

@export_group("Resources")
@export var building : BuildingResource
@export var play_sound : bool = true

signal on_builded
signal on_upgraded

var current_level : int = 0
var current_resources : Dictionary[ItemResource, int]
var current_needed_resources : Dictionary[ItemResource, int]
var is_upgrading : bool = false

func _enter_tree() -> void:
	is_upgrading = true
	set_fences()
	init_resources(current_level)
	update_resources()
	

func init_resources(level : int) -> void:
	current_needed_resources.clear()
	current_resources.clear()
	for r in building.resources[level]:
		current_needed_resources[r] = building.resources[level][r]
		current_resources[r] = 0

func set_fences() -> void:
	fence_layer.clear()
	var w : int = (building.size.x+2)/2
	var h : int = (building.size.y+2)/2
	var cells : Array[Vector2i] = []
	for x in range(-w,w):
		cells.append(Vector2i(x,h-1))
		cells.append(Vector2i(x,-h))
	for y in range(-h,h):
		cells.append(Vector2i(-w,y))
		cells.append(Vector2i(w-1,y))
	fence_layer.set_cells_terrain_connect(cells, 0,0)

func update_resources() -> void:
	var all_good : bool = true
	for r in current_needed_resources:
		if current_needed_resources[r] != current_resources[r]:
			all_good = false
	if all_good:
		build_level()
	ui.update_resource_requirements(current_resources, current_needed_resources)

func add_resource(item : Item) -> void:
	var r : ItemResource = item.item_resource
	if is_upgrading and current_resources.keys().has(r):
		if current_resources[r] < current_needed_resources[r]:
			current_resources[r]+=1
			item.queue_free()
		update_resources()

func build_level() -> void:
	if current_level == 0:
		on_builded.emit()
	on_upgraded.emit()
	ui.hide()
	fence_layer.hide()
	sprite.show()
	sprite.texture = building.textures[current_level]
	current_level+=1
	is_upgrading = false
	if play_sound:
		audio.play()
		var explosion = explosion_effect.instantiate()
		add_child(explosion)
