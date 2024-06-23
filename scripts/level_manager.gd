extends Node

var score = 0

func _ready():
	NodePaths.current_level = "LevelMenu"

func add_point():
	score += 1
	print(score)
