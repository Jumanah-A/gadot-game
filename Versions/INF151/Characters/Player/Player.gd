extends Character

var SwordPoints = 2
var IsAttacking1 = false
var IsAttacking2 = false
export(int) var attacking_move_speed: int = 45
#testing commit

onready var sword: Node2D = get_node("Sword")
onready var sword_hitbox: Area2D = get_node("Sword/Attack1Hitbox")
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")

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


func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
	if IsAttacking1:
		velocity = velocity.clamped(attacking_move_speed)
	elif IsAttacking2:
		velocity = velocity.clamped(max_speed)
		velocity = lerp(velocity, Vector2.ZERO, 0.8)
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
	
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing() and SwordPoints == 2:
		$AttackResetTimer.start()
		$SlowMoveOnAttackTimer.start()
		sword_animation_player.play("attack1")
		IsAttacking1 = true
		yield(get_tree().create_timer(0.25), "timeout")
		SwordPoints -= 1
	elif Input.is_action_just_pressed("ui_attack") and sword_animation_player.is_playing() and SwordPoints == 1:
		$AttackResetTimer.start()
		$SlowMoveOnAttackTimer.start()
		sword_animation_player.play("attack2")
		IsAttacking2 = true
		SwordPoints -= 1


func _on_SwordAnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack1" || anim_name == "attack2":
		sword_animation_player.play("RESET")


func _on_AttackResetTimer_timeout():
	SwordPoints = 2


func _on_SlowMoveOnAttackTimer_timeout():
	IsAttacking1 = false
	IsAttacking2 = false
