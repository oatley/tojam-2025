extends Node2D

var level1 = "res://Scenes/level_1.tscn"

func load_level_1():
	get_tree().change_scene_to_file(level1)


func _on_texture_button_pressed() -> void:
	load_level_1()
	pass # Replace with function body.
