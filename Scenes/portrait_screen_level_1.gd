extends Node2D

var happy_face = load("res://Assets/tojam25_photoFace1.png")
var neutral_face = load("res://Assets/tojam25_photoFace2.png")
var sad_face = load("res://Assets/tojam25_photoFace3.png")

func change_face(sender, face):
	var current_face
	if face == "happy":
		current_face = happy_face
	elif face == "neutral":
		current_face = neutral_face
	else:
		current_face = sad_face
	if sender == "Claire":
		
		$TextureRectPortrait/TextureRectClareFace.texture = current_face
		$TextureRectPortrait/TextureRectClareFace.visible = true
		
	
