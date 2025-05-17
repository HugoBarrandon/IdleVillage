extends Control

class_name Hud

@export var score_label : RichTextLabel
@export var science_container : Control

@export var build_bar : Control
@export var custom_button_scene : PackedScene

func update_score(score : int) -> void :
	score_label.text = str(score)

func unlock_science(science : ScienceResource) -> void :
	for building in science.unlocked_buildings:
		var button : CustomButton = custom_button_scene.instantiate()
		button.icon = building.textures[0]
		build_bar.add_child(button)
		button.pressed.connect(_on_building_button_pressed.bind(building))

func _on_belt_button_pressed() -> void:
	pass # Replace with function body.


func _on_building_button_pressed(building : BuildingResource) -> void:
	Preview.instance.select_building(building)
	GameManager.build_manager.select_building(building)

func display_science(b: bool) -> void:
	science_container.visible = b
