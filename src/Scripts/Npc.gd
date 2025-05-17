extends CharacterBody2D

class_name Npc

var sprite : Texture2D
@export var animator : AnimationPlayer

var follow_mouse : bool = false
var last_body : Node2D = null
var target :Node2D = null

func _enter_tree() -> void:
	animator.play("ready")

func _process(_delta: float) -> void:
	if follow_mouse:
		position = get_global_mouse_position() + Vector2(0,14)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			follow_mouse = true
			animator.play("idle")
		else:
			follow_mouse = false
			drop()

func drop() -> void:
	target = last_body
	if target != null and target.is_in_group("Resources"):
		position = World.overworld.map_to_local(World.overworld.local_to_map(target.position))
		position -= Vector2(16,0)
		animator.play("use_item")
	else:
		animator.play("ready")

func _on_logic_body_entered(body: Node2D) -> void:
	last_body = body

func _on_logic_body_exited(_body: Node2D) -> void:
	last_body = null

func _on_use_item() -> void:
	if target != null:
		target.drop_item()
