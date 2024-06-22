class_name Inventory extends Popup

@export var item_placer: ItemPlacer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		popup_centered()
	


func _on_stairs_button_pressed():
	print("pressed stair button")
	item_placer.item_to_place = "res://scenes/stair.tscn"
	visible = false


func _on_arrow_box_button_pressed():
	item_placer.item_to_place = "res://scenes/arrow_box.tscn"
	visible = false
