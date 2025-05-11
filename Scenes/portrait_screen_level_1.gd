extends Node2D

var faceSuperSmile = load("res://Assets/tojam25_photoFace1.png")
var faceSmile = load("res://Assets/tojam25_photoFace2.png")
var faceSad = load("res://Assets/tojam25_photoFace3.png")

func clare_face(face):
	$TextureRectPortrait/TextureRectClareFace.texture = face
	
