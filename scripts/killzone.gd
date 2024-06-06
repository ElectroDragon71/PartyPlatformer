extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("you ded")
	_multiplayer_dead(body)

func _multiplayer_dead(body):
	if body.alive:
		body.mark_dead()
