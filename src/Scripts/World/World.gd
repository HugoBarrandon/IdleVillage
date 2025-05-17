extends Node2D

class_name World

static var instance : World
static var overworld : TileMapLayer

@export var overworld_map : TileMapLayer

@export var npc_scene : PackedScene
@export var npc_container : Node2D

@export var item_scene : PackedScene
@export var item_container : Node2D

func _enter_tree() -> void:
	instance = self
	overworld = overworld_map

static func align_on_grid(node : Node2D) -> void:
	var p = node.position
	node.position = overworld.map_to_local(overworld.local_to_map(p))

func spawn_npc(world_pos : Vector2 = Vector2.ZERO):
	var npc : Npc = npc_scene.instantiate()
	npc.position = world_pos
	align_on_grid(npc)
	npc_container.add_child(npc)

func spawn_item(item : ItemResource, world_pos : Vector2 = Vector2.ZERO) -> void:
	var i : Item = Item.new_item(item)
	i.position = world_pos
	align_on_grid(i)
	item_container.add_child(i)
