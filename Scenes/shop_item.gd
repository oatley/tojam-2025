extends BoxContainer

# 0 accesses first Texture Button and 1 accesses second texture button
var button1_title# = "title"
var button2_title# = "title"
var button1_text#  = "text_body"
var button2_text# = "text_body"

var level

func change_image(button, image, col1, col2):
	if button == 0:
		$TextureButton/ImageItem.gen_item(image,col1,col2)
	elif button == 1:
		$TextureButton2/ImageItem.gen_item(image,col1,col2)

func change_id(button, id):
	if button == 0:
		$TextureButton/ImageItem.item_id = id
	elif button == 1:
		$TextureButton2/ImageItem.item_id = id

func change_body(button, text):
	#print("shop_item.gd: text ", text)
	if not text or text == "":
		text = "SCREEEEE FILL IN DATA"
	if button == 0:
		button1_text = str(text)
		$TextureButton/LabelBody.text = button1_text
	elif button == 1:
		button2_text = str(text)
		$TextureButton2/LabelBody.text = button2_text
	pass
	
func change_title(button, text):
	#print("shop_item.gd: text ", text)
	if not text or text == "":
		text = "SCREEEEE FILL IN DATA"
	if button == 0:
		button1_title = str(text)
		$TextureButton/LabelTitle.text = button1_title
	elif button == 1:
		button2_title = str(text)
		$TextureButton2/LabelTitle.text = button2_title
	pass

func _on_texture_button_pressed() -> void:
	var root_node = get_node("/root/Level"+str(level))
	root_node.sound_click.play()
	root_node.selected_cart_item = $TextureButton/ImageItem.item_art_asset
	root_node.selected_cart_col1 = $TextureButton/ImageItem.item_col1
	root_node.selected_cart_col2 = $TextureButton/ImageItem.item_col2
	root_node.selected_cart_item_id = $TextureButton/ImageItem.item_id

func _on_texture_button_2_pressed() -> void:
	var root_node = get_node("/root/Level"+str(level))
	root_node.sound_click.play()
	root_node.selected_cart_item = $TextureButton2/ImageItem.item_art_asset
	root_node.selected_cart_col1 = $TextureButton2/ImageItem.item_col1
	root_node.selected_cart_col2 = $TextureButton2/ImageItem.item_col2
	root_node.selected_cart_item_id = $TextureButton2/ImageItem.item_id
