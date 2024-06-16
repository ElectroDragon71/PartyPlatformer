extends Item

@export var arrow = preload("res://scenes/arrow.tscn")

@onready var timer = $Timer

const MAX_DELAY = 100
var delay = MAX_DELAY
var timer_started = false
func _ready():
	super._ready()

func _process(delta):
	rotate(1 * delta)
	if timer_started == false && previewing == false:
		timer.start()
		timer_started = true
	

func fire():
	var a = arrow.instantiate()
	a.global_position = $ArrowSpawn.global_position
	a.rotation_degrees = rotation_degrees
	get_tree().root.add_child(a)


func _on_timer_timeout():
	fire()
