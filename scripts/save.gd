extends Node

const SAVEFILE = "user://SAVEFILE.txt"

var game_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()


func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file == null:
		game_data = {
			"fullscreen_on": false,
			"master_vol": 0,
			"music_vol": -14,
			"sfx_vol": 0
		}
		save_data()
	game_data = file.get_var()
	file.close()

func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
	file.close()
