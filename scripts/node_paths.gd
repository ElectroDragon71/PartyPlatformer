extends Node

var current_level

func get_level():
	get_tree().root.get_node(current_level)
