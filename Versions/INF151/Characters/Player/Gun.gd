extends Sprite

var can_fire = true
var bullet = preload("res://Bullet.tscn")

func _ready():
	set_as_toplevel(true)


func _physics_process(_delta):
	position.x = lerp(position.x, get_parent().position.x + 1, 0.7)
	position.y = lerp(position.y, get_parent().position.y - 6, 0.7)
	
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	# handles fliping gun image so that it's never upside-down
	if mouse_pos[0] < get_parent().position.x:
		flip_v = true
	else:
		flip_v = false
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $Position2D.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(0.65), "timeout")
		can_fire = true

