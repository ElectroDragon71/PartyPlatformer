extends Node

var score = 0

func _ready():
	NodePaths.current_level_path = self.get_parent().get_path()

func add_point():
	score += 1
	print(score)
