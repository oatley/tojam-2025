extends Node2D

# Tabs
var tab_names = []
var tab_nodes = []
var tab = preload("res://Scenes/tab.tscn")

# Items
var items = []


#func _process (delta):
	##if not tabs:
		##if $Items.isReady:
			##tabs = $Items.item_general_categories
			###print("store.gd: ", tabs)
	#pass


func _ready():
	tab_names = $Items.item_general_categories
	#create_tabs() # Changing to a drop down
	pass

func create_items():
	items = $Items.items
	
	pass



func create_tabs():
	var posx = 0 # +150 min
	var posy = 0 
	for category in tab_names:
		var instance = tab.instantiate()
		instance.name = category
		instance.change_text(category)
		var posxy = Vector2(posx, posy)
		instance.position = posxy
		tab_nodes.append (instance)
		add_child(instance)
		posx += 200
	pass
