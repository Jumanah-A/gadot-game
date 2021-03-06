extends Area2D


export var speed = 160

func _ready():
	set_as_toplevel(true)


func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _physics_process(_delta):
	yield(get_tree().create_timer(0.01), "timeout")
	$Sprite.frame = 1
	set_physics_process(false)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(_body):
	Global.enemy_killed()
	queue_free()
