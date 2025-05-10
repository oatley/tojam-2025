extends BoxContainer

# 0 accesses first Texture Button and 1 accesses second texture button
var button1_title# = "title"
var button2_title# = "title"
var button1_text#  = "text_body"
var button2_text# = "text_body"


#func _ready():
	#$TextureButton/LabelTitle.text = button1_title
	#$TextureButton2/LabelTitle.text = button2_title
	#$TextureButton/LabelBody.text = button1_text
	#$TextureButton2/LabelBody.text = button2_text
	#print("shop_item.gd: button ready ")
	#change_body(0, )


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
