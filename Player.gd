extends KinematicBody2D

export (int) var walk_speed = 200
export (int) var jump_speed = -400

var GRAVITY = 1000 #ProjectSettings.get_setting("physics/2d/default_gravity")

var velocity = Vector2(0,0)
var jumping = false

onready var initialPos = $Gun.position
onready var initialTf = $Gun.transform

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('move_right')
	var left = Input.is_action_pressed('move_left')
	var jump = Input.is_action_just_pressed('jump')
	var modifier = Input.is_action_pressed("modify_action")
	var run_multiplier = 1
	if modifier:
		run_multiplier = 2

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += walk_speed*run_multiplier
	if left:
		velocity.x -= walk_speed*run_multiplier

func _physics_process(delta):
	get_input()
	velocity.y += GRAVITY * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func _process(delta):
	# Gun pointing
	var	rotation = get_global_mouse_position().angle_to_point(position)
	
	if (rotation > -PI/2 and rotation < PI/2):
		$PlayerAnimation.set_flip_h(false)
		$Gun.position.x = initialPos.x
		$Gun.transform = initialTf
	else:
		$PlayerAnimation.set_flip_h(true)
		$Gun.transform = initialTf
		$Gun.position.x = -initialPos.x
		$Gun.transform *= Transform2D.FLIP_Y

	$Gun.rotation = rotation

	# Animation
	if abs(velocity.x) > 0 and velocity.y == 0:
		$PlayerAnimation.play("walk")
	elif velocity.x == 0 and velocity.y == 0:
		$PlayerAnimation.play("walk")
		$PlayerAnimation.frame = 0
		$PlayerAnimation.stop()
	if velocity.y < 0:
		$PlayerAnimation.play("jump")
		$PlayerAnimation.frame = 2
		$PlayerAnimation.stop()
	if velocity.y > 0:
		$PlayerAnimation.play("jump")
		$PlayerAnimation.frame = 3
		$PlayerAnimation.stop()
	
	
