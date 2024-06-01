class_name Trail
extends Line2D

var point = Vector2()
const MAX_POINTS = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = Vector2(0,-8)
	global_rotation = 0
	point = get_parent().global_position
	add_point(point)
	if get_point_count() > MAX_POINTS:
		remove_point(0)
