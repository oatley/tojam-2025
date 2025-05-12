extends Node2D

#Time
var time = 0

# Tabs
var current_tab = "All"
var tab_names = []
var tab_nodes = []
var tab_scene = preload("res://Scenes/tab_container.tscn") # Old Scene

# Shop Items
var shop_item_scene = preload("res://Scenes/shop_item.tscn")

var level = 2

# Items
var items = []

func print_debug_text():
	#print("store.gd: items ", items)
	#print("store.gd: general categories ", tab_names)
	pass
	
func _process (delta):
	time += delta
	if time > 0.25:
		if $Sort.tab != current_tab:
			#print("changing tabs to", $Sort.tab)
			if $Sort.tab == "All":
				hide_tabs()
			else:
				unhide_tab($Sort.tab)
		time = 0
	
func _ready():
	tab_names = []
	tab_names.append("All")
	tab_names = tab_names + $Items.item_general_categories
	
	items = $Items.items
	fill_sort_menu()
	#test_create_tabs()
	create_tabs()
	#hide_tabs()
	unhide_tab("Electronics")
	hide_tabs()
	$Sort.store = self
	pass

# By default hide all tabs except ALL
func hide_tabs():
	for tab in tab_nodes:
		#print(tab, " ", tab.name)
		if tab.name == "All":
			tab.visible = true
		else:
			tab.visible = false
	pass

# Unhide specific tab
func unhide_tab(tab_to_unhide):
	for tab in tab_nodes:
		#print(tab, " ", tab.name)
		if tab.name == tab_to_unhide:
			tab.visible = true
		else:
			tab.visible = false
	pass

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
	
	# Item 1
	var item1_title
	var item1_body
	var item1_image_base
	var item1_image_col1
	var item1_image_col2
	var item1_id
	
	# Item 2
	var item2_title
	var item2_body
	var item2_image_base
	var item2_image_col1 # "Colour 1"
	var item2_image_col2 # "Colour 2"
	var item2_id
	
	#print("store: items", items[3])
	for item in items:
		if not item["First Level Added"]or not item["General Category"] or not item["Specific Category"] or not item["Art Notes"]:
			continue
		if item["First Level Added"] != str(level):
			continue
			
		if count > 1:
			count = 0
		#print ("item: ",item)
		#print("gen cat: ", item["General Category"], " tab value: ", tab)
		
		if item["General Category"] == tab or tab == "All":
			var item_title = item["Store Name"] # placeholder for "Store Name"
			#var item_title = item["Specific Category"] # placeholder for "Store Name"
			var item_desc = item["Store Description"] # placeholder for "Store Description"
			if count == 0:
				item1_title = item_title
				item1_body = item_desc
				item1_image_base = item["Art Asset"]
				item1_image_col1 = item["Colour 1"]
				item1_image_col2 = item["Colour 2"]
				item1_id = item["Item ID"]
			elif count == 1:
				item2_title = item_title
				item2_body = item_desc
				item2_image_base = item["Art Asset"]
				item2_image_col1 = item["Colour 1"]
				item2_image_col2 = item["Colour 2"]
				item2_id = item["Item ID"]
			#print("store.gd: change text on button ", item_title)
			if count == 1:
				#print ("store.gd: item", item)
				var shop_item_instance = shop_item_scene.instantiate()
				#print ("store.gd: adding shop item", shop_item_instance, "------", item1_body, "-----", item2_body)
				tab_container.add_child(shop_item_instance)
				shop_item_instance.level = level
				
				# item1 
				shop_item_instance.change_title(0, item1_title)
				shop_item_instance.change_body(0, item1_body)
				# button, art_asset, col1, col2
				shop_item_instance.change_image(0, item1_image_base, item1_image_col1, item1_image_col2)
				shop_item_instance.change_id(0, item1_id)
				
				# item2
				shop_item_instance.change_title(1, item2_title)
				shop_item_instance.change_body(1, item2_body)
				# button, art_asset, col1, col2
				shop_item_instance.change_image(1, item2_image_base, item2_image_col1, item2_image_col2)
				shop_item_instance.change_id(1, item2_id)
				
			count += 1
	pass

# Fill the sort menu with tab_names to filter the tabs
func fill_sort_menu():
	#print (tab_names)
	for tab in tab_names:
		#print (tab)
		$Sort/MenuButton.get_popup().add_item(str(tab))
	pass
