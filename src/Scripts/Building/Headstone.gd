extends Building

class_name Headstone

func _enter_tree() -> void:
	pass

func add_resource(item : Item) -> void:
	var r : ItemResource = item.item_resource
	GameManager.instance.add_resource(r, item.number)
	item.queue_free()
