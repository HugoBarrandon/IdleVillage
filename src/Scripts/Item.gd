extends StaticBody2D

class_name Item

enum STATE{Idle, FOLLOW_MOUSE, BELT}
const item_scene : PackedScene = preload("res://Scenes/Items/Item.tscn")

#Children
@export var icon : Sprite2D

#Basic
var item_resource : ItemResource
var colliding_body : Node2D = null
var current_state : STATE = STATE.Idle
var number : int = 1

@onready var number_label : RichTextLabel = $Control/Number

#Belts
@export var speed : float = 1
var move_direction : Vector2i = Vector2i.ZERO
var next_move_direction : Vector2i = Vector2i.ZERO
var total_move : float = 0


static func new_item(resource : ItemResource) -> Item:
	var i : Item = item_scene.instantiate()
	i.item_resource = resource
	i.icon.texture = resource.texture
	return i

func _process(delta: float) -> void:
	match current_state:
		STATE.FOLLOW_MOUSE:
			position = get_global_mouse_position()
		STATE.BELT:
			var movement = min((delta * speed), 16 - total_move)
			move_and_collide(move_direction * movement)
			total_move += movement
			if total_move >= 16:
				total_move = 0
				check_move_direction()
				move_direction = next_move_direction


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		if event.is_pressed():
			z_index = 10
			current_state = STATE.FOLLOW_MOUSE
		else :
			z_index = 0
			drop()

func add_item(n : int = 1) -> void:
	number+=n
	number_label.text = str(number)

func drop() -> void:
	current_state = STATE.Idle
	if colliding_body != null:
		if colliding_body.is_in_group("Belts"):
			current_state = STATE.BELT
			position = colliding_body.map_to_local(colliding_body.local_to_map(position))
			check_move_direction()
			move_direction = next_move_direction
			total_move = 0
		elif colliding_body.is_in_group("Buildings"):
			var building : Building = colliding_body.get_parent()
			building.add_resource(self)

func _on_collider_entered(body: Node2D) -> void:
	colliding_body = body
	if current_state == STATE.Idle:
		drop()

func _on_collider_exited(body: Node2D) -> void:
	if body == colliding_body:
		body = null

func check_move_direction() -> void:
	if colliding_body == null or not colliding_body.is_in_group("Belts"):
		drop()
		return
	var cell_pos = colliding_body.local_to_map(position)
	if colliding_body.get_cell_source_id(cell_pos) == -1:
		next_move_direction = Vector2i.ZERO
		return
	var t = colliding_body.is_cell_transposed(cell_pos)
	var f_h = colliding_body.is_cell_flipped_h(cell_pos)
	var f_v = colliding_body.is_cell_flipped_v(cell_pos)
	
	if t and f_h:
		next_move_direction = Vector2i.RIGHT
	elif f_h and f_v:
		next_move_direction = Vector2i.DOWN
	elif t and f_v:
		next_move_direction = Vector2i.LEFT
	else:
		next_move_direction = Vector2i.UP
