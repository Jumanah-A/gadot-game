extends Node2D

export (PackedScene) var inside_scn



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Doorway_body_entered(body):
	body.door = self



func _on_Doorway_body_exited(body):
	if body.door == self:
		body.door = null
		
func enter():
	get_tree().change_scene(inside_scn.resource_path)
