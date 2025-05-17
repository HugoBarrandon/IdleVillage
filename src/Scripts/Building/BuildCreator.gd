@tool
extends Node2D

class_name BuildCreator

@export var tilemap : TileMapLayer
@export_tool_button("Save") var save_button = save_map
@export_tool_button("Load") var load_button = load_existing_map


var path_map_data ="res://file_map.bin"

func load_existing_map():
	var content = FileAccess.get_file_as_bytes(path_map_data)
	tilemap.set_tile_map_data_from_array(content)

func save_map():
	var txtFile = FileAccess.open(path_map_data,FileAccess.WRITE)
	var array = tilemap.get_tile_map_data_as_array()
	txtFile.store_buffer(array)
