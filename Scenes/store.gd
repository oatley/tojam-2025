extends Node2D

# Tabs
var tab_names = []
var tab_nodes = []
var tab_scene = preload("res://Scenes/tab_container.tscn") # Old Scene

# Shop Items
var shop_item_scene = preload("res://Scenes/shop_item.tscn")

# Items
var items = []

func print_debug_text():
	print("store.gd: items ", items)
	print("store.gd: general categories ", tab_names)
	pass
	
func _ready():
	tab_names = $Items.item_general_categories
	items = $Items.items
	
	fill_sort_menu()
	#test_create_tabs()
	create_tabs()
	pass

func hide_tabs():
	
	pass

#

# Create a new tab_container for each tab_names
func create_tabs():
	for tab in tab_names:
		if not tab:
			continue
		var tab_container_instance = tab_scene.instantiate()
		tab_container_instance.name = str(tab)
		tab_nodes.append(tab_container_instance)
		$ScrollContainer.add_child(tab_container_instance)
		#create items inside a tab?
		#create_items(tab, tab_container_instance)
		create_items(tab, tab_container_instance)
	pass

# Generate item objects inside tabs
func create_items(tab, tab_container):
	var count = 0 # put two items in each shop_items_box
	#var shop_item_instance = shop_item_scene.instantiate()
	#tab_container.add_child(shop_item_instance)
	var item1_title
	var item2_title
	var item1_body
	var item2_body
	for item in items:
		if not item["General Category"] or not item["Specific Category"] or not item["Art Notes"]:
			continue
		if count > 1:
			count = 0
		#print ("item: ",item)
		#print("gen cat: ", item["General Category"], " tab value: ", tab)
		if item["General Category"] == tab or tab == "All":
			var item_title = item["Specific Category"] # placeholder for "Store Name"
			var item_desc = item["Art Notes"] # placeholder for "Store Description"
			if count == 0:
				item1_title = item_title
				item1_body = item_desc
			elif count == 1:
				item2_title = item_title
				item2_body = item_desc
			#shop_item_instance.change_title(count, item_title)
			#shop_item_instance.change_title(count, tab)
			#shop_item_instance.change_body(count, item_desc)
			#print("store.gd: change text on button ", item_title)
			if count == 1:
				var shop_item_instance = shop_item_scene.instantiate()
				print ("store.gd: adding shop item", shop_item_instance, "------", item1_body, "-----", item2_body)
				tab_container.add_child(shop_item_instance)
				shop_item_instance.change_title(0, item1_title)
				shop_item_instance.change_body(0, item1_body)
				shop_item_instance.change_title(1, item2_title)
				shop_item_instance.change_body(1, item2_body)
			count += 1
	pass





# Fill the sort menu with tab_names to filter the tabs
func fill_sort_menu():
	print (tab_names)
	for tab in tab_names:
		print (tab)
		$Sort/MenuButton.get_popup().add_item(str(tab))
	pass

# Old tab buttons. No longer use?
#func create_tabs_OLD():
	#var posx = 0 # +150 min
	#var posy = 0 
	#for category in tab_names:
		#var instance = tab_scene.instantiate()
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
	
	
#func test_create_tabs():
	#var tab = "Toys"
	#var tab_container_instance = tab_scene.instantiate()
	#tab_container_instance.name = str(tab)
	#tab_nodes.append(tab_container_instance)
	#$ScrollContainer.add_child(tab_container_instance)
	#var shop_item_instance = shop_item_scene.instantiate()
	#tab_container_instance.add_child(shop_item_instance)
