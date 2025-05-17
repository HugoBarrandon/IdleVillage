@tool
extends PanelContainer

class_name HudItemResource

@export var item : ItemResource: set = _set_item

@export var icon : TextureRect
@export var label : RichTextLabel

func _set_item(i : ItemResource) -> void:
	item = i
	set_quantity(0)
	if i == null:
		icon.texture = null
	else:
		icon.texture = i.texture

func set_quantity(quantity : int) -> void:
	label.text = str(quantity)
