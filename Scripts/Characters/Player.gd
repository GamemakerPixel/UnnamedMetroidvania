extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 30
const ACCELERATION = 50
var max_speed = 500
var jump_height = -1200
var health
export (float) var max_health
export (Vector2) var specializedZoom

var jumpRemember = 0
var jumpRemembered
var validJump = true

var motion = Vector2()
var motionAllowed = true
var dialogRunning = false
var dialogToPrint
var dialogSize

func _ready():
	if specializedZoom != Vector2(0, 0):
		$Camera2D.zoom = specializedZoom
	set_camera_limits()
	$CanvasLayer/Transition/AnimationPlayer.play("fadein")

func set_camera_limits():
	if get_parent() != null:
		var usedRect = get_parent().get_node("Walls").get_used_rect()
		usedRect.position *= Vector2(64, 64)
		usedRect.size *= Vector2(64, 64)
		print(usedRect)
		$Camera2D.limit_left = usedRect.position.x
		$Camera2D.limit_right = usedRect.position.x + usedRect.size.x
		$Camera2D.limit_top = usedRect.position.y
		$Camera2D.limit_bottom = usedRect.position.y + usedRect.size.y

func _process(delta):
	if dialogRunning:
		motionAllowed = false
	if not is_on_floor():
		jumpRemember += delta
		if jumpRemember > 0.2:
			validJump = false
	else:
		if jumpRemembered != null:
			if jumpRemember - jumpRemembered < 0.1 && jumpRemember - jumpRemembered > 0:
				motion.y = jump_height
		jumpRemember = 0
		validJump = true
	
	checkAbilityInput()

func checkAbilityInput():
	if Input.is_action_pressed("ui_spell_screech"):
		if GlobalVariables.abilities[0]:
			pass
	if Input.is_action_just_pressed("ui_spell_reveal"):
		if GlobalVariables.abilities[1]:
			if $Ranges/Reveal.colliding_bodies != null:
				for body in $Ranges/Reveal.colliding_bodies:
					print(body)
					if body.is_in_group("fakeWall"):
						body.get_parent().destroy()

func _physics_process(delta):
	if motionAllowed:
		var friction = false
		
		if Input.is_action_pressed("ui_right"):
			if motion.x < 0:
				motion.x = lerp(motion.x, 0, 0.5)
			motion.x = min(motion.x+ACCELERATION, max_speed)
	
			
			
		elif Input.is_action_pressed("ui_left"):
			if motion.x > 0:
				lerp(motion.x, 0, 0.5)
			motion.x = max(motion.x-ACCELERATION, -max_speed)
		else:
			friction = true
			motion.x = lerp(motion.x, 0, 0.3)
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_height
				validJump = false
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.3)
		else:
			if Input.is_action_just_pressed("ui_up"):
				if validJump:
					motion.y = jump_height
					validJump = false
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

func printDialog(dialog):
	dialogRunning = true
	dialogToPrint = dialog
	dialogSize = dialog.size()

func unlockAbility(ability):
	print("UNLOCKED - " + str(ability))
	GlobalVariables.abilities[ability] = true