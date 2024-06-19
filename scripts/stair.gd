extends Item

@onready var player_id: String = get_node("..").name

#func _ready():
	#%ItemSynchronizer.set_multiplayer_authority(player_id.to_int())
