extends Node2D

@onready var level = get_parent().level
var is_email_open = false
var button_pressed = false

func set_gift_objective(gift_num, objective):
	var node = get_node("LabelGiftIdeasObjective" + str(gift_num))
	node.text = str(objective)

func _on_texture_button_pressed() -> void:
	button_pressed = true
	pass # Replace with function body.
