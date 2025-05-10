extends Node2D

# Tabs
var tab_names = []
var tab_nodes = []
#var tab_scene = preload("res://Scenes/tab.tscn") # Old Scene


# Items
var items = []




func _ready():
	tab_names = $Items.item_general_categories
	#print("store.gd: general categories ", tab_names)
	fill_sort_menu()
	pass





# Fill the sort menu with tab_names to filter the tabs
func fill_sort_menu():
	print (tab_names)
	for tab in tab_names:
		print (tab)
		$Sort/MenuButton.get_popup().add_item(str(tab))
		
	pass

# Old tab buttons. No longer use?
#func create_tabs():
	#var posx = 0 # +150 min
	#var posy = 0 
	#for category in tab_names:
		#var instance = tab.instantiate()
		#instance.name = category
		#instance.change_text(category)
		#var posxy = Vector2(posx, posy)
		#instance.position = posxy
		#tab_nodes.append (instance)
		#add_child(instance)
		#posx += 200
	#pass
	
#func _process (delta):
	##if not tabs:
		##if $Items.isReady:
			##tabs = $Items.item_general_categories
			###print("store.gd: ", tabs)
	#pass

#
#func create_items():
	#items = $Items.items	
	#pass
