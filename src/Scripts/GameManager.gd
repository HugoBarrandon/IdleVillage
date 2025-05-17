extends Control

class_name GameManager

enum State{idle}

static var instance : GameManager
static var build_manager : BuildManager

@export var hud : Hud

var score : int = 0

func _init() -> void:
	instance = self

func add_resource(item : ItemResource, number : int) -> void:
	score += (item.score * number)
	hud.update_score(score)

func unlock_science(science : ScienceResource) -> void :
	hud.unlock_science(science)
