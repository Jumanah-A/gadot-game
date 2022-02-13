extends "res://Spawner.gd"

export var spawning_radius = 100.0

func _ready():
	spawn()

func spawn():
	var spawnling = .spawn()
	
	var radial_offset = Vector2.RIGHT.rotated(rand_range(0.0, TAU))
	radial_offset *= rand_range(0.0, spawning_radius)
	
	spawnling.global_position += radial_offset
	return spawnling
	
