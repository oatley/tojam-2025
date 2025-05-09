extends Node2D

var tabs = []
var tab_nodes = []
var tab = preload("res://Scenes/tab.tscn")


#func _process (delta):
	##if not tabs:
		##if $Items.isReady:
			##tabs = $Items.item_general_categories
			###print("store.gd: ", tabs)
	#pass


func _ready():
	tabs = $Items.item_general_categories
	print ("store.gd", tabs)
	create_tabs()
	pass

func create_tabs():
	var posx = 0 # +150 min
	var posy = 0 
	for category in tabs:
		
		var instance = tab.instantiate()
		instance.name = category
		instance.change_text(category)
		var posxy = Vector2(posx, posy)
		instance.position = posxy
		tab_nodes.append (instance)
		add_child(instance)
		posx += 200
	pass
