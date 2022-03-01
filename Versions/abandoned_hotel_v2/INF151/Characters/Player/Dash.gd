extends Node2D

const run_speed = 95
const run_acceleration = 55
const dash_speed = 5000
const dash_acceleration = 150
const dash_duration = 0.1

const dash_delay = 0.4
onready var duration_timer =  $DurationTimer
onready var ghost_timer = $GhostTimer
var ghost_scene =  preload("res://Characters/Player/DashGhost.tscn")
var can_dash = true
var sprite


func start_dash(sprite):
	get_parent().max_speed = dash_speed
	get_parent().acceleration = dash_acceleration
	self.sprite = sprite
	print("start dashing")
	duration_timer.wait_time = dash_duration
	duration_timer.start()
	ghost_timer.start()
	instance_ghost()

func instance_ghost():
	var ghost: AnimatedSprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.frames = self.sprite.frames
	ghost.animation = self.sprite.animation 
	ghost.frame = self.sprite.frame
	ghost.flip_h =  self.sprite.flip_h
	
func is_dashing():
	return !duration_timer.is_stopped()
	
func end_dash():
	get_parent().max_speed = run_speed
	get_parent().acceleration = run_acceleration
	ghost_timer.stop()
	can_dash = false
	yield(get_tree().create_timer(dash_delay),"timeout")
	can_dash=true

func _on_DurationTimer_timeout():
	end_dash()


func _on_GhostTimer_timeout():
	instance_ghost()
