extends Node2D

const run_speed = 95
const run_acceleration = 55
const dash_speed = 5000
const dash_acceleration = 100

const dash_delay = 0.4
onready var duration_timer =  $DurationTimer
var ghost_scene =  preload("res://Characters/Player/DashGhost.tscn")
var can_dash = true
var sprite


func start_dash(sprite,duration):
	get_parent().max_speed = dash_speed
	get_parent().acceleration = dash_acceleration
	self.sprite = sprite
	print("start dashing")
	duration_timer.wait_time = duration
	duration_timer.start()
	instance_ghost()

func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	
#	ghost.global_position = global_position
#	ghost.texture = sprite.texture
#	ghost.vframes = sprite.vframes
#	ghost.hframes =  sprite.hframes
#	ghost.frame = sprite.frame
#	ghost.flip_h =  sprite.flip_h
	
func is_dashing():
	return !duration_timer.is_stopped()
	
func end_dash():
	get_parent().max_speed = run_speed
	get_parent().acceleration = run_acceleration
	can_dash = false
	yield(get_tree().create_timer(dash_delay),"timeout")
	can_dash=true

func _on_DurationTimer_timeout():
	end_dash()
