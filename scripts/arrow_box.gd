extends Item

@export var arrow = preload("res://scenes/arrow.tscn")

@onready var timer = $Timer

const MAX_DELAY = 100
var delay = MAX_DELAY
var timer_started = false

@export var replicated_position : Vector2
@export var replicated_rotation : float

func _ready():
	super._ready()

func _physics_process(_delta):
	if previewing == false:
		rotation += .01
		if timer_started == false:
			timer.start()
			timer_started = true
	#_sync()

func _sync():
	if is_multiplayer_authority():
		replicated_position = position
		replicated_rotation = rotation
	else:
		position = replicated_position
		rotation = replicated_rotation

func fire():
	var a = arrow.instantiate()
	a.global_position = $ArrowSpawn.global_position
	a.rotation_degrees = rotation_degrees
	get_tree().root.get_node("LevelMenu/Projectiles").add_child(a)


func _on_timer_timeout():
	fire()
