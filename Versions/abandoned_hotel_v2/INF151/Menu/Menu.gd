extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer2/VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
		
	if $AudioStreamPlayer2.playing == false:
		$AudioStreamPlayer2.play()


func _on_Start_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_Options_pressed():
	print("Options pressed")


func _on_Quit_pressed():
	get_tree().quit()
