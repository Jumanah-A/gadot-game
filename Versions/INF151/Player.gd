extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 8
const MAX_SPEED = 64
const FRICTION = 10
const AIR_RESISTANCE = 1
const GRAVITY = 5
const JUMP_FORCE = 140

# edits: ==============
const DASH_SPEED = 256
var dashing = false
var dash_wait = false
var jump_reset = false
# =====================

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

# edits: ==============
#func _process(_delta: float) -> void:
#	if Input.is_action_just_pressed("ui_select") and dashing == false:
#		dash()
# =====================	


func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		animationPlayer.play("Run")
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0		# gets character to face direction moving
	else:
		animationPlayer.play("Stand")
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		jump_reset = true
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up") and jump_reset == true:
			jump_reset = false
			motion.y = -JUMP_FORCE		# negative is up in the y-axis
	else:
		jump_reset = false
		animationPlayer.play("Jump")
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	# edits: ==========
	#if dashing == false:
	#	if Input.is_action_pressed("ui_left") and !dashing == true:
	#		motion.x = lerp(motion.x, -MAX_SPEED, FRICTION * delta)
	#	if Input.is_action_pressed("ui_right") and !dashing == true:
	#		motion.x = lerp(motion.x, MAX_SPEED, FRICTION * delta)
	#	elif !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
	#		motion.x = lerp(motion.x, 0, FRICTION * delta)
	# =================
	
	# second argument tells move_and_slide which direction is up.
	# Vector2.UP is Vector2's default up direction
	motion = move_and_slide(motion, Vector2.UP)


#func dash():
#dashing = true
#	motion.x = DASH_SPEED
#	yield(get_tree().create_timer(0.3), "timeout")
#	motion.x = lerp(motion.x, 0, 0.05)
#	dashing = false
#	pass
