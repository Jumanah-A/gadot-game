extends KinematicBody2D
class_name Character

const FRICTION: float = 0.15

export(int) var hp: int = 3
export(int) var acceleration: int = 55
export(int) var max_speed: int = 90


onready var dash = $Dash
#onready var sprite =  $Sprite
const dash_speed = 40000
const move_speed = 8000
const dash_duration = 0.2

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
#	dashing logic
#	print(dash.can_dash)
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
#		dash.start_dash(sprite, dash_duration)
		dash.start_dash(dash_duration)
		
	var speed = dash_speed if dash.is_dashing() else move_speed
	
	velocity = mov_direction * speed * _delta
	
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
#	restrict charcter to screen size
	position += velocity * _delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
#	not sure if we should clamp the speed at max speed or dash speed??
	velocity = velocity.clamped(max_speed)
	


func take_damage(dam: int, dir: Vector2, force: int) -> void:
	hp -= dam
	print(hp)
	if hp > 0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2
