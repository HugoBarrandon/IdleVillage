extends Control
class_name BuildUi

@export var resource_container : VBoxContainer
@export var resource_requirement : PackedScene

var current_resources : Dictionary[ItemResource, ResourceRequirement] =  {}

func update_resource_requirements(resources : Dictionary[ItemResource, int], needs: Dictionary[ItemResource, int]) -> void :
	for r in resources:
		var rr : ResourceRequirement
		if not current_resources.keys().has(r):
			rr = resource_requirement.instantiate()
			resource_container.add_child(rr)
			current_resources[r] = rr
		else:
			rr = current_resources[r]
		rr.update(r.texture, resources[r], needs[r])
