class_name Item extends AnimatableBody2D

const SHADER = preload("res://resources/shaders/item.gdshader")
const SHADER_PREVIEW = "PREVIEW"
const SHADER_PLACEABLE = "PLACEABLE"

@onready var sprite = $Sprite2D
@onready var cpoly = $CollisionPolygon2D

var previewing: bool:
	get:
		return previewing
	set(value):
		previewing = value
		_update_shader()

var can_place: bool:
	get:
		return can_place
	set(value):
		can_place = value
		_update_shader()

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.material = SHADER.duplicate()

func set_collision_enabled(enabled):
	call_deferred("_deferred_set_collision_enabled", enabled)

func _deferred_set_collision_enabled(enabled):
	cpoly.disabled = !enabled

func _update_shader():
	if sprite.material == null:
		return
	sprite.material.set_shader_parameter(SHADER_PREVIEW, previewing)
	sprite.material.set_shader_parameter(SHADER_PLACEABLE, can_place)

func _on_placement_allowed_changed(placement_allowed):
	can_place = placement_allowed
