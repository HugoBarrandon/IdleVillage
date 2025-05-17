extends Resource

class_name ScienceResource

@export var name : String = ""
@export var icon : Texture
@export var cost : int = 0
@export var condition : Dictionary[BuildingResource, int] = {}
@export var unlocked_buildings : Array[BuildingResource] = []
