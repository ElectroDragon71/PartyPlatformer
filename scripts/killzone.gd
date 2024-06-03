extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	print("you ded")
	timer.start()


func _on_timer_timeout():
	pass
