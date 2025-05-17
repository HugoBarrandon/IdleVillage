extends HBoxContainer
class_name ResourceRequirement

@export var icon : TextureRect
@export var number : RichTextLabel

func update(texture : Texture, fill : int, need : int) -> void:
	icon.texture = texture
	number.text = str(fill, "/", need)
