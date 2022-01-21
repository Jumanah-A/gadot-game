extends Character

var SwordPoints = 2

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
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing() and SwordPoints == 2:
		$AttackResetTimer.start()
		sword_animation_player.play("attack1")
		SwordPoints -= 1
	elif Input.is_action_just_pressed("ui_attack") and sword_animation_player.is_playing() and SwordPoints == 1:
		$AttackResetTimer.start()
		sword_animation_player.play("attack2")
		SwordPoints -= 1


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


func _on_SwordAnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack1" || anim_name == "attack2":
		sword_animation_player.play("RESET")


func _on_AttackResetTimer_timeout():
	SwordPoints = 2