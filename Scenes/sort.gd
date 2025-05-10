extends Node2D

var tab = "All"
var store

func _ready():
	$MenuButton.get_popup().id_pressed.connect(_on_menu_button_pressed)

func _on_menu_button_pressed(id: int) -> void:
	print("sort.gd: set sort to ",$MenuButton.get_popup().get_item_text(id))
	tab = $MenuButton.get_popup().get_item_text(id)
	pass
