extends Node


func toggle_fullscreen(value):
	# 0 is windowed, 4 is fullscreen
	DisplayServer.window_set_mode(value)
	Save.game_data.fullscreen_on

func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)

func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)

func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
