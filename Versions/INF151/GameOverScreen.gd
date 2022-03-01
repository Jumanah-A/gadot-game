extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayAgainButton_pressed() -> void:
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
	
