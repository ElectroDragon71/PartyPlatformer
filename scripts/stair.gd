extends Item

@export var replicated_position : Vector2
@export var replicated_rotation : float

func _physics_process(delta):
	#_sync()
	pass

func _sync():
	if is_multiplayer_authority():
		replicated_position = position
		replicated_rotation = rotation
	else:
		position = replicated_position
		rotation = replicated_rotation
