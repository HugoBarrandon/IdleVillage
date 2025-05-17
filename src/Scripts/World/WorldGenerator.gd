extends Node2D

class_name WorldGenerator

@onready var overworld_map : TileMapLayer = $"../Layers/OverworldTileMap"
@onready var wall_map : TileMapLayer = $"../Layers/WallTileMap"
@onready var sea_map : TileMapLayer = $"../Layers/SeaTileMap"

@export var fnl : FastNoiseLite

func _ready() -> void:
	overworld_map.clear()
	randomize()
	fnl.seed = randi()
	generateMap()

func generateMap() -> void:
	var size : int  = 100
	for x in range(-size, size+1):
		for y in range(-size, size+1):
			var noiseVal := fnl.get_noise_2d(x,y)
			if noiseVal > 0.25:
				overworld_map.set_cell(Vector2i(x,y),0, Vector2i(2,2))
			elif noiseVal > 0.20:
				overworld_map.set_cell(Vector2i(x,y),0, Vector2i(2,1))
			else:
				overworld_map.set_cell(Vector2i(x,y),0, Vector2i(1,0))
