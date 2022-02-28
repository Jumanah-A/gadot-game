extends Character




var SwordPoints = 3
var IsAttacking1 = false
var IsAttacking2 = false
var IsAttacking3 = false
var IsAttackingSpecial = false
var door = null setget set_door
export(int) var attacking_move_speed: int = 45


onready var sword: Node2D = get_node("Sword")
onready var sword_hitbox: Area2D = get_node("Sword/AttackHitbox")
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")

#dash code
onready var dash = $Dash
onready var sprite = $AnimatedSprite


func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	
	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1
		
		
	
#	restrict charcter to screen size
#	position += velocity * _delta
#	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
#	position.y = clamp(position.y, 0, get_viewport_rect().size.y)


func move() -> void:
	mov_direction = get_move_direction().normalized()
	velocity += mov_direction * acceleration
	if IsAttacking1:
		velocity = velocity.clamped(attacking_move_speed)
	elif IsAttacking2:
		velocity = velocity.clamped(max_speed)
		velocity = lerp(velocity, Vector2.ZERO, 0.8)
	elif IsAttacking3:
		velocity = velocity.clamped(max_speed)
		velocity = lerp(velocity, Vector2.ZERO, 0.4)
	elif IsAttackingSpecial:
		velocity = velocity.clamped(max_speed)
		velocity = lerp(velocity, Vector2.ZERO, 0.4)
	else:
		velocity = velocity.clamped(max_speed)


func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
		
#	DASH
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite)
	
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing() and SwordPoints == 3:
		$AttackResetTimer.start()
		$SlowMoveOnAttackTimer.start()
		sword_animation_player.play("attack1")
		IsAttacking1 = true
		yield(get_tree().create_timer(0.25), "timeout")
		SwordPoints -= 1
	elif Input.is_action_just_pressed("ui_attack") and sword_animation_player.is_playing() and SwordPoints == 2:
		$AttackResetTimer.start()
		$SlowMoveOnAttackTimer.start()
		sword_animation_player.play("attack2")
		IsAttacking2 = true
		SwordPoints -= 1
	elif Input.is_action_just_pressed("ui_attack") and sword_animation_player.is_playing() and SwordPoints == 1:
		$AttackResetTimer.start()
		sword_animation_player.play("attack3")
		IsAttacking3 = true
		SwordPoints -= 1
		yield(get_tree().create_timer(0.5), "timeout")
		IsAttacking3 = false
	elif Input.is_action_just_pressed("ui_special_attack"):
		sword_animation_player.play("special_attack")
		IsAttackingSpecial = true
		yield(get_tree().create_timer(0.5), "timeout")
		IsAttackingSpecial = false


func _on_SwordAnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack1" || anim_name == "attack2" || anim_name == "attack3" || anim_name == "special_attack":
		sword_animation_player.play("RESET")


func _on_AttackResetTimer_timeout():
	SwordPoints = 3


func _on_SlowMoveOnAttackTimer_timeout():
	IsAttacking1 = false
	IsAttacking2 = false


func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right"))- int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down"))- int(Input.is_action_pressed("ui_up")))
		
		

func set_door(new_door):
	if new_door != null:
		$Key.show()
	else:
		$Key.hide()
		
	door = new_door
		
func _ready():
	set_door(null)
	
func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interact") and door != null:
		door.enter()
	



