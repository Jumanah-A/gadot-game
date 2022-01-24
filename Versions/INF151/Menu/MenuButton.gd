tool
extends TextureButton


export(String) var text= "Text Button"
export(int) var arrow_margin = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	text()
	hgrim()
	set_focus_mode(true)
	
	
func _process(delta):
	if Engine.editor_hint:
		text()
		grim()

func text():
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [text]
	
	
func grim():
		for bomb in [$grim1, $grim2]:
			bomb.visible = true
			bomb.global_position.y = rect_global_position.y + (rect_size.y/4.0)
			
		var center_x = rect_global_position.x + (rect_size.x / 2)
		$grim1.global_position.x = center_x - arrow_margin
		$grim2.global_position.x = center_x + arrow_margin
		
		
func hgrim():
	for bomb in [$grim1, $grim2]:
		bomb.visible = false
		


	
func _on_TextureButton_focus_entered():
	grim()
	

func _on_TextureButton_focus_exited():
	hgrim()


func _on_TextureButton_mouse_entered():
	grab_focus()
