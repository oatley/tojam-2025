extends Node2D

@export var level: int

# Control
var is_checkout = false

@export var image_item: Node2D

func set_checkout_label(text):
	$TextureButtonCheckout/LabelCheckout.text = text

func change_checkout_image(image):
	pass


func _on_texture_button_checkout_pressed() -> void:
	is_checkout = true
	var root_node = get_parent()
	root_node.add_to_cart()
	root_node.sound_click.play()
	pass # Replace with function body.
