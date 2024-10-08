class_name ItemPlacer extends Node2D

@export var player: MultiplayerPlayer

# The current world node
var world: Node2D:
	get:
		return player.get_parent().get_parent()

var item_node: Node2D:
	get:
		return world.get_node("Items")

# String that is the path to the item scene
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
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if preview_instance != null:
		var mouse_position = get_global_mouse_position()
		var rounded_position = Vector2(int(round(mouse_position.x)), int(round(mouse_position.y)))
		preview_instance.global_position = rounded_position

func _unhandled_input(_event):
	if preview_instance == null:
		return
	if Input.is_action_just_pressed("place_item"):
		print("attempting to place item")
		_place_item()

func _clear_preview():
	if preview_instance == null:
		return
	
	preview_instance.queue_free()

func _create_placement_preview():
	print("create placement preview")
	print(item_to_place)
	_create_placement_preview_server.rpc_id(1, item_to_place)

func _place_item():
	if preview_instance == null:
		return
	
	if not preview_instance.can_place:
		print("can't place item")
		return
	
	print("placing item")
	preview_instance.set_collision_enabled(true)
	preview_instance.previewing = false
	preview_instance = null
	item_to_place = ""

# RPC's

@rpc("any_peer", "call_local", "reliable")
func _create_placement_preview_server(item):
	if multiplayer.is_server():
		var remote_id = multiplayer.get_remote_sender_id()
		print("generating preview instance")
		print(item)
		if item == "":
			return
		
		#create the preview
		var preview_scene = load(item)
		preview_instance = preview_scene.instantiate() as Item
		preview_instance.set_collision_enabled(false)
		item_node.add_child(preview_instance, true)
		print(str(remote_id))
		self._handoff.rpc(preview_instance.name, remote_id)
		preview_instance.previewing = true

# Hands off the multiplayer authority to the player who chose the item
@rpc("call_local")
func _handoff(node_name, auth_id):
	get_node(NodePaths.current_level_path).get_node("Items/" + node_name).set_multiplayer_authority(auth_id)

# Sets local Preview Instance
@rpc("any_peer", "call_local", "reliable")
func _set_preview_instance(instance):
	print(instance.name)
	preview_instance = instance
