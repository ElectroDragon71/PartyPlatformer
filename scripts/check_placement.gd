class_name CheckPlacement extends Area2D

signal placement_allowed_changed(allowed: bool)

var placement_allowed: bool = true:
	get:
		return placement_allowed
	set(value):
		placement_allowed = value
		emit_signal("placement_allowed_changed", value)

func _ready():
	set_active(false)
	
func set_active(active):
	visible = active

func _check_collisions():
	var colliding_area = !get_overlapping_areas().filter(
		func(area: Area2D):
			return area.get_parent() != get_parent()
	).is_empty()
	
	placement_allowed = colliding_area

func _on_area_entered(area):
	_check_collisions()
