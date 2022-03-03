extends Node2D

var enemy_1 = preload("res://Characters/Enemies/Zombie/Zombie.tscn")

func _init() -> void:
	var screen_size: Vector2 = OS.get_screen_size()
	var window_size: Vector2 = OS.get_window_size()
	
	OS.set_window_position(screen_size * 0.5 - window_size * 0.5)

#func _ready():
#	$EnemySpawnTimer.start()


func _on_EnemySpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(100, 800), rand_range(100, 550))
	print(enemy_position)
	
#	while enemy_position.x < 640 and enemy_position.x > -80 or enemy_position.y < 360 and enemy_position.y > -45:
#		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
		
	Global.instance_node(enemy_1, enemy_position, self)
