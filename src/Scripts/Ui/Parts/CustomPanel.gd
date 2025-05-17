@tool
extends Control

class_name CustomPanel

@export var hide_background : bool :
	set(value):
		if value != null :
			$Background.visible = !value
		hide_background = value

@export var angle : Texture2D :
	set(value):
		if value != null :
			$Corner.texture = value
		angle = value
