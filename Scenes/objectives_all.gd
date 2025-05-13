extends Node2D

@export var level: int
var is_email_open = false
var button_pressed = true

func set_profile_pic(image):
	$ProfilePic.texture = load(image)

func set_label_contact(text):
	$LabelContact.text = text
	
func set_label_subject(text):
	$LabelSubject.text = text

func set_gift_objective(gift_num, objective):
	var node = get_node("LabelGiftIdeasObjective" + str(gift_num))
	node.text = str(objective)

func _on_texture_button_pressed() -> void:
	var root_node = get_node("/root/Level"+str(level))
	root_node.sound_click.play()
	button_pressed = true
	pass # Replace with function body.
