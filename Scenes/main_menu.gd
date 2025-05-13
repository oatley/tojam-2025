extends Node2D

var level1 = "res://Scenes/level_1.tscn"

func load_level_1():
	get_tree().change_scene_to_file(level1)

func _on_texture_button_pressed() -> void:
	load_level_1()

func _on_texture_button_exit_pressed() -> void:
	# Check platform if web don't do anything and if not web exit
	if OS.has_feature("web") or OS.has_feature("debug"):
		print("main_menu.gd: can't exit web silly")
	else:
		get_tree().quit()

# Play Button click
func _on_texture_button_button_down() -> void:
	$AudioStreamPlayerButtonClick.play()
	pass

# Exit button click
func _on_texture_button_exit_button_down() -> void:
	$AudioStreamPlayerButtonClick.play()
	pass
	
