extends Node2D

const SPEED = 100

var direction : Vector2

@onready var break_arrow = $BreakArrow

func _ready():
	direction = Vector2(1,0).rotated(rotation)

func _process(delta):
	position += direction * SPEED * delta


func _on_area_2d_body_entered(_body):
	break_arrow.play("break")
