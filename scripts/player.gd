extends CharacterBody2D

@export var CROUCH_SPEED = 50
@export var NORMAL_SPEED = 100
@export var SPRINT_SPEED = 200
@export var MIN_JUMP_VELOCITY = 100
@export var MAX_JUMP_VELOCITY = 250
@export var JUMP_VELOCITY_INCREMENT = 30
@export var MAX_GRAVITY = 28
@export var NORMAL_GRAVITY = 20
@export var LOW_GRAVITY = 10
@export var GRAVITY_INCREMENT = 1.5

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D
@onready var crouch_raycast1 = $CrouchRaycast1
@onready var crouch_raycast2 = $CrouchRaycast2

var speed = NORMAL_SPEED
var gravity = NORMAL_GRAVITY
var is_crouching = false
var stuck_under_object = false
var in_air = false
var jumping = false

var standing_cshape = preload("res://resources/player_standing_cshape.tres")
var crouching_cshape = preload("res://resources/player_crouching_cshape.tres")

func _ready():
	pass

func _physics_process(_delta):
	# Gravity.
	if not is_on_floor():
		velocity.y += gravity
	else:
		gravity = NORMAL_GRAVITY

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_crouching and !stuck_under_object:
		jumping = true
		gravity = LOW_GRAVITY
		velocity.y = -MIN_JUMP_VELOCITY
	elif jumping == true and Input.is_action_pressed("jump"):
		if is_on_ceiling():
			jumping = false
		else:
			gravity += GRAVITY_INCREMENT
			velocity.y += -JUMP_VELOCITY_INCREMENT
			if gravity > MAX_GRAVITY:
				gravity = MAX_GRAVITY
			if velocity.y <= -MAX_JUMP_VELOCITY:
				jumping = false
				velocity.y = -MAX_JUMP_VELOCITY
	else:
		jumping = false
		
	if jumping == false:
		gravity -= GRAVITY_INCREMENT
		if(gravity <= NORMAL_GRAVITY):
			gravity = NORMAL_GRAVITY
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	
	# Sets horizontal velocity
	if(Input.is_action_pressed("sprint") && !is_crouching):
		sprint()
	elif(Input.is_action_just_released("sprint") && !is_crouching):
		walk()
	
	velocity.x = direction * speed

	# Animation Direction
	if(direction != 0):
		switch_direction(direction)
		

	# Crouching
	if(Input.is_action_just_pressed("crouch")):
		if is_on_floor():
			crouch()
		else:
			in_air = true
	elif(Input.is_action_just_released("crouch")):
		if(above_head_is_empty()):
			stand()
		else:
			stuck_under_object = true
	
	if(stuck_under_object && above_head_is_empty() && !Input.is_action_pressed("crouch")):
		stand()
		stuck_under_object = false
	elif(in_air && is_on_floor() && Input.is_action_pressed("crouch")):
		crouch()
		in_air = false
	elif(!is_on_floor()):
		stand()
		in_air = true
	
		
	move_and_slide()
	
	update_animations(direction)
	print("velocity: " + str(velocity.y))
	print("gravity: " + str(gravity))
	print(jumping)

func above_head_is_empty() -> bool:
	if(crouch_raycast1.is_colliding() || crouch_raycast2.is_colliding()):
		return false
	else:
		return true

func update_animations(direction):
	if is_on_floor():
		if(direction == 0):
			if(is_crouching):
				ap.play("crouch")
			else:
				ap.play("idle")
		else:
			if(is_crouching):
				ap.play("crouch_walk")
			else:
				ap.play("run")
	else:
		if(velocity.y < 0):
			ap.play("jump")
		else:
			ap.play("fall")

func switch_direction(direction):
	sprite.flip_h = (direction == -1)
	
func sprint():
	speed = SPRINT_SPEED

func walk():
	speed = NORMAL_SPEED
	
func crouch():
	speed = CROUCH_SPEED
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = -7
	
func stand():
	speed = NORMAL_SPEED
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -15

func set_jump_velocity():
	pass
	
