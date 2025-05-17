@tool
extends Control

class_name CustomButton

signal pressed

@export var disabled : bool :
	set(value):
		disabled = value
		if value != null :
			$TextureButton.disabled = value

@export var icon : Texture :
	set(value):
		icon = value
		if value != null :
			$TextureButton.texture_normal = value
			
@export var angle : Texture :
	set(value):
		angle = value
		if value != null :
			$CustomPanel.angle = value


func on_pressed() -> void:
	pressed.emit()
