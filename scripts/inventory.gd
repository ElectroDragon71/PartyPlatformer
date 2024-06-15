class_name Inventory extends Popup

@export var item_placer: ItemPlacer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_stairs_button_pressed():
	print("pressed stair button")
	item_placer.item_to_place = "res://scenes/stair.tscn"


func _on_arrow_box_button_pressed():
	pass # Replace with function body.
