class_name CheckPlacement extends Area2D

signal placement_allowed_changed(allowed: bool)

var placement_allowed: bool = true:
	get:
		return placement_allowed
	set(value):
		print("placement_allowed changed to " + str(value))
		placement_allowed = value
		placement_allowed_changed.emit(value)

func _ready():
	set_active(false)
	
func set_active(active):
	visible = active

func _check_collisions():
	var colliding_area = !get_overlapping_areas().filter(
		func(area: Area2D):
			return area.get_parent() != get_parent()
	).is_empty()
	print("colliding area: " + str(colliding_area))
	placement_allowed = colliding_area

func _on_area_entered(area):
	print("entered")
	_check_collisions()



func _on_body_entered(body):
	placement_allowed = false


func _on_body_exited(body):
	placement_allowed = true
