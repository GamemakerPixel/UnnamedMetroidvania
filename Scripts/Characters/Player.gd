extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
var max_speed = 700
var jump_height = -900
var health
export (float) var max_health

var jumpRemember = 0
var jumpRemembered
var validJump = true

var motion = Vector2()

func _process(delta):
	if not is_on_floor():
		jumpRemember += delta
		if jumpRemember > 0.2:
			validJump = false
	else:
		if jumpRemembered != null:
			if jumpRemember - jumpRemembered < 0.2 && jumpRemember - jumpRemembered > 0:
				motion.y = jump_height
		jumpRemember = 0
		validJump = true

func _physics_process(delta):
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, max_speed)

		
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -max_speed)
	else:
		friction = true
		motion.x = lerp(motion.x, 0, 0.3)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump_height
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.3)
	else:
		if Input.is_action_just_pressed("ui_up"):
			if validJump:
				motion.y = jump_height
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		if not Input.is_action_pressed("ui_up"):
			if motion.y < 0:
				motion.y *= 0.5
	if Input.is_action_just_pressed("ui_up"):
		jumpRemembered = jumpRemember
	motion.y += GRAVITY
	
	
	motion = move_and_slide(motion, UP)
	pass