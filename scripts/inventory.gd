class_name Inventory extends Window

@export var item_placer: ItemPlacer

# Called when the node enters the scene tree for the first time.
func _ready():
	borderless = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_stairs_button_pressed():
	print("pressed stair button")
	visible = false
	item_placer.item_to_place = "res://scenes/stair.tscn"


func _on_arrow_box_button_pressed():
	visible = false
	item_placer.item_to_place = "res://scenes/arrow_box.tscn"


func _on_inv_button_pressed():
	visible = true
