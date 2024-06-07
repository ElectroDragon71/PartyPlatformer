extends Control

@onready var settings_menu = $SettingsMenu


func _on_host_pressed():
	var game_scene = load("res://scenes/game.tscn").instantiate()
	get_tree().root.add_child(game_scene)
	self.hide()
	
	MultiplayerManager.become_host()



func _on_join_pressed():
	var game_scene = load("res://scenes/game.tscn").instantiate()
	get_tree().root.add_child(game_scene)
	self.hide()
	MultiplayerManager.join_as_client()


func _on_exit_game_pressed():
	get_tree().quit()


func _on_settings_pressed():
	settings_menu.popup_centered()
