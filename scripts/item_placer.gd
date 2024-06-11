class_name ItemPlacer extends Node2D

@export var player: MultiplayerPlayer
@export var inventory: Inventory

var world: Node2D:
	get:
		return player.get_parent().get_parent()

var item_to_place: String:
	get:
		return item_to_place
	set(item):
		_clear_preview()
		item_to_place = item
		_create_placement_preview()

var preview_instance: Item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if preview_instance != null:
		var mouse_position = get_global_mouse_position()
		var rounded_position = Vector2(int(round(mouse_position.x)), int(round(mouse_position.y)))
		preview_instance.global_position = rounded_position

func _unhandled_input(event):
	if preview_instance == null:
		return
	
	if Input.is_action_just_pressed("place_item"):
		_place_item()

func _clear_preview():
	if preview_instance == null:
		return
	
	preview_instance.queue_free()

func _create_placement_preview():
	if item_to_place == "":
		return
	
	#create the preview
	var preview_scene = load(item_to_place)
	preview_instance = preview_scene.instantiate() as Item
	preview_instance.set_collision_enabled(false)
	world.add_child(preview_instance)
	preview_instance.previewing = true

func _place_item():
	if preview_instance == null:
		return
	
	if not preview_instance.can_place:
		return
	
	preview_instance.set_collision_enabled(true)
	preview_instance.previewing = false
	preview_instance = null
	item_to_place = ""
