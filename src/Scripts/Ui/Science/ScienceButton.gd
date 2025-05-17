@tool
extends Control

class_name ScienceButton

#External --------------------------------------------
@export var science : ScienceResource :
	set(value):
		science = value
		$CustomButton.icon = value.icon

#Internal --------------------------------------------
@onready var button : CustomButton = $CustomButton
static var borders : Array[Texture] = [
	preload("res://Assets/GUI/Panels/CornersSilver.png"),
	preload("res://Assets/GUI/Panels/CornersGold2.png"),
	preload("res://Assets/GUI/Panels/CornersGold.png")
]

func on_pressed() -> void:
	if GameManager.instance.score >= science.cost:
		GameManager.instance.unlock_science(science)
		button.disabled = true
		button.angle = borders[2]
