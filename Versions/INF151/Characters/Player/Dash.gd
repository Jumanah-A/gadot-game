extends Node2D

onready var duration_timer =  $DurationTimer
var dash_delay = 0.4
var can_dash = true
#var ghost_scene = preload("res://Characters/Player/DashGhost.tscn")
var sprite


# Called when the node enters the scene tree for the first time.

#func start_dash(sprite,duration):
func start_dash(duration):
#	self.sprite = sprite
	print("start dahsin")
	duration_timer.wait_time = duration
	duration_timer.start()
	
#	ghost scene
#	instance_ghost()

#func instance_ghost():
#	var ghost:Sprite = ghost_scene.instance()
#	get_parent().get_parent().add_child(ghost)
#
#	ghost.global_position = global_position
#	ghost.texture = sprite.texture
#	ghost.vframes = sprite.vframes
#	ghost.hframes =  sprite.hframes
#	ghost.frame = sprite.frame
#	ghost.flip_h =  sprite.flip_h

func is_dashing():
	return !duration_timer.is_stopped()
	
func end_dash():
	can_dash = false
	yield(get_tree().create_timer(dash_delay),"timeout")
	can_dash=true

func _on_DurationTimer_timeout():
	end_dash()
