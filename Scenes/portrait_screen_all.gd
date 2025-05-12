extends Node2D

@onready var level = get_parent().level

var happy_face = load("res://Assets/tojam25_photoFace1.png")
var neutral_face = load("res://Assets/tojam25_photoFace2.png")
var sad_face = load("res://Assets/tojam25_photoFace3.png")

var main_menu = "res://Scenes/main.tscn"


# Flash
var time = 0
var brightness = 255


func _process(delta):
	time += delta
	#print(time)
	if time > 0.05:
		time = 0
		#print(time)
		#print ("DOOOT", brightness)
		$TextureRectFlash.modulate = Color.from_rgba8(255,255,255,brightness)
		brightness -= 10
		if brightness < 0:
			$TextureRectFlash.visible = false
			
			
func hide_flash():
	$TextureRectFlash.visible = false

func unhide_flash():			
	$TextureRectFlash.visible = true

func change_face(sender, face):
	var current_face
	var face_location
	if face == "happy":
		current_face = happy_face
	elif face == "neutral":
		current_face = neutral_face
	else:
		current_face = sad_face
	print(sender)
	face_location = get_node("TextureRectPortrait/TextureRect"+sender+"Face")
	face_location.texture = current_face
	face_location.visible = true
	#if sender == "Claire":
		#$TextureRectPortrait/TextureRectClareFace.texture = current_face
		#$TextureRectPortrait/TextureRectClareFace.visible = true
		
	
func load_main_menu():
	get_tree().change_scene_to_file(main_menu)

func load_next_level():
	get_tree().change_scene_to_file("res://Scenes/level_"+ str(level+1) +".tscn")
	pass

func _on_texture_button_pressed() -> void:
	#load_main_menu()
	load_next_level()
	pass # Replace with function body.
