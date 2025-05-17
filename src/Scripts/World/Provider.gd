@tool
extends StaticBody2D

class_name Provider

@export var provider : ProviderResource : set = _set_provider
@export var sprite : Sprite2D
@export var collider : CollisionShape2D

@onready var raycast_drop : RayCast2D = $RayCast2D


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		drop_item()

func drop_item() -> void:
	if raycast_drop.is_colliding():
		var c : Node2D = raycast_drop.get_collider()
		if c.get_parent() is Item:
			var i : Item = c.get_parent() as Item
			i.add_item()
			return
	World.instance.spawn_item(provider.loot, position + Vector2.DOWN*16)

func _set_provider(p : ProviderResource) -> void:
	provider = p
	if p != null:
		sprite.texture = p.sprite
		var pos = Vector2(0,p.sprite.get_size().y)
		pos = pos/2 - Vector2(0,8)
		sprite.position = -pos
		collider.position = -pos
		collider.shape = RectangleShape2D.new()
		collider.shape.size = p.sprite.get_size()
	else:
		sprite.texture = null
		sprite.position = Vector2.ZERO
		collider.position = Vector2.ZERO
		collider.shape = null
