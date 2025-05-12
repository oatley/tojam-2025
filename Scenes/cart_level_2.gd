extends Node2D

# Control
var is_checkout = false
var level = 2



func change_checkout_image(image):
	pass


func _on_texture_button_checkout_pressed() -> void:
	is_checkout = true
	var root_node = get_node("/root/Level2")
	root_node.add_to_cart()
	pass # Replace with function body.
