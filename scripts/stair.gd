extends Item

@export var replicated_position : Vector2
@export var replicated_rotation : float

func _physics_process(_delta):
	_sync()

func _sync():
	if %ItemSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		replicated_position = position
		replicated_rotation = rotation
	else:
		position = replicated_position
		rotation = replicated_rotation
