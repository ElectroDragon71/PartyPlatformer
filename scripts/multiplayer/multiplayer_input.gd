extends MultiplayerSynchronizer

var input_direction
var inputs

## Enables/Disables hard movement when using a joystick.  When enabled, slightly moving the joystick
## will only move the character at a percentage of the maximum acceleration and speed instead of the maximum.
@export var JOYSTICK_MOVEMENT := false

@export_group("Input Map Actions")
# Input Map actions related to each movement direction, jumping, and sprinting.  Set each to their related
# action's name in your Input Mapping or create actions with the default names.
@export var ACTION_UP := "up" ## The input mapping for up
@export var ACTION_DOWN := "down" ## The input mapping for down
@export var ACTION_LEFT := "left" ## The input mapping for left
@export var ACTION_RIGHT := "right" ## The input mapping for right
@export var ACTION_JUMP := "jump" ## The input mapping for jump
@export var ACTION_SPRINT := "sprint" ## The input mapping for sprint

@export var ENABLE_SPRINT := true

# Called when the node enters the scene tree for the first time.
#func _ready():
	#if get_multiplayer_authority() != multiplayer.get_unique_id():
		#set_process(false)
		#set_physics_process(false)
	#
	#input_direction = get_input_direction()
	#inputs = get_inputs()
#
#func _physics_process(delta):
	#input_direction = get_input_direction()
	#inputs = get_inputs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_inputs() -> Dictionary:
	return {
		input_direction = get_input_direction(),
		jump_strength = Input.get_action_strength(ACTION_JUMP),
		jump_pressed = Input.is_action_just_pressed(ACTION_JUMP),
		jump_released = Input.is_action_just_released(ACTION_JUMP),
		sprint_strength = Input.get_action_strength(ACTION_SPRINT) if ENABLE_SPRINT else 0.0,
	}

## Gets the X/Y axis movement direction using the input mappings assigned to the ACTION UP/DOWN/LEFT/RIGHT variables
func get_input_direction() -> Vector2:
	var x_dir: float = Input.get_action_strength(ACTION_RIGHT) - Input.get_action_strength(ACTION_LEFT)
	var y_dir: float = Input.get_action_strength(ACTION_DOWN) - Input.get_action_strength(ACTION_UP)

	return Vector2(x_dir if JOYSTICK_MOVEMENT else sign(x_dir), y_dir if JOYSTICK_MOVEMENT else sign(y_dir))
